import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../database/app_database.dart' show AppDatabase;
import '../database/app_database.dart' as db;
import '../models/contract.dart' as contract_models;
import '../models/contractor.dart' as contractor_models;
import '../models/company.dart' as company_models;
import '../models/invoice.dart' as invoice_models;
import '../models/invoice_item.dart' as invoice_item_models;
import 'entity_repository.dart';

class InvoiceRepository extends ChangeNotifier implements EntityRepository<invoice_models.Invoice> {
  final AppDatabase _db;

  InvoiceRepository(this._db);

  @override
  Future<List<invoice_models.Invoice>> getAll() async {
    final invoices = await _db.select(_db.dbInvoices).get();
    final result = <invoice_models.Invoice>[];
    for (final invoice in invoices) {
      result.add(await _toModel(invoice));
    }
    return result;
  }

  @override
  Future<invoice_models.Invoice?> getById(String id) async {
    final invoice = await (_db.select(_db.dbInvoices)..where((i) => i.id.equals(id)))
        .getSingleOrNull();
    return invoice != null ? _toModel(invoice) : null;
  }

  @override
  Future<void> save(invoice_models.Invoice invoice) async {
    await _db.transaction(() async {
      final contract = invoice.contract;

      final contractJson = json.encode({
        'id': contract.id,
        'contractorId': contract.contractor.id,
        'companyId': contract.company.id,
        'date': contract.date.toIso8601String(),
        'fixed': contract.fixed,
        'defaultPrice': contract.defaultPrice,
        'showPeriod': contract.showPeriod,
        'qtyLabel': contract.qtyLabel,
        'priceLabel': contract.priceLabel,
        'descriptionLabel': contract.descriptionLabel,
        'amountLabel': contract.amountLabel,
        'periodLabel': contract.periodLabel,
        'totalLabel': contract.totalLabel,
        'dueDateLabel': contract.dueDateLabel,
        'dateLabel': contract.dateLabel,
        'invoiceIdLbl': contract.invoiceIdLbl,
        'invoiceTitle': contract.invoiceTitle,
        'description': contract.description,
        'contractorRoleSublabel': contract.contractorRoleSublabel,
        'footnote': contract.footnote,
        'contractorAgreementLabel': contract.contractorAgreementLabel,
        'locale': contract.locale,
      });

      final contractorJson = json.encode({
        'id': contract.contractor.id,
        'abbr': contract.contractor.abbr,
        'fullName': contract.contractor.fullName,
        'paymentInfo': contract.contractor.paymentInfo,
        'contractorInfo': contract.contractor.contractorInfo,
        'signature': contract.contractor.signature != null
            ? base64Encode(contract.contractor.signature as Uint8List)
            : null,
        'createdAt': contract.contractor.createdAt.toIso8601String(),
        'updatedAt': contract.contractor.updatedAt.toIso8601String(),
      });

      final companyJson = json.encode({
        'id': contract.company.id,
        'name': contract.company.name,
        'abbr': contract.company.abbr,
        'paymentWeeks': contract.company.paymentWeeks,
        'currencyPrefix': contract.company.currencyPrefix,
        'companyInfo': contract.company.companyInfo,
        'updatedAt': contract.company.updatedAt.toIso8601String(),
      });

      // Сохраняем Invoice с snapshot данными
      await _db.into(_db.dbInvoices).insert(
            db.DbInvoice(
              id: invoice.id,
              date: invoice.date,
              dueDate: invoice.dueDate,
              status: invoice.status.index,
              contractSnapshot: contractJson,
              contractorSnapshot: contractorJson,
              companySnapshot: companyJson,
            ),
            mode: InsertMode.insertOrReplace,
          );

      // Удаляем старые invoice items
      await (_db.delete(_db.dbInvoiceItems)..where((i) => i.invoiceId.equals(invoice.id))).go();

      // Сохраняем новые invoice items
      for (final item in invoice.items) {
        await _db.into(_db.dbInvoiceItems).insert(
              db.DbInvoiceItem(
                id: item.id,
                invoiceId: invoice.id,
                description: item.description,
                period: item.period,
                quantity: item.quantity,
                price: item.price,
                amount: item.amount,
              ),
              mode: InsertMode.insert,
            );
      }
    });
    notifyListeners();
  }

  @override
  Future<void> delete(String id) async {
    await _db.transaction(() async {
      await (_db.delete(_db.dbInvoiceItems)..where((i) => i.invoiceId.equals(id))).go();
      await (_db.delete(_db.dbInvoices)..where((i) => i.id.equals(id))).go();
    });
    notifyListeners();
  }

  Future<invoice_models.Invoice> _toModel(db.DbInvoice data) async {
    final contract = _snapshotToContract(data);
    final itemsData =
        await (_db.select(_db.dbInvoiceItems)..where((i) => i.invoiceId.equals(data.id))).get();
    final items = itemsData.map((item) => _itemToModel(item)).toList();

    return invoice_models.Invoice(
      id: data.id,
      contract: contract,
      date: data.date,
      dueDate: data.dueDate,
      items: items,
      status: invoice_models.InvoiceStatus.values[data.status],
    );
  }

  contract_models.Contract _snapshotToContract(db.DbInvoice data) {
    final contractData = json.decode(data.contractSnapshot) as Map<String, dynamic>;
    final contractorData = json.decode(data.contractorSnapshot) as Map<String, dynamic>;
    final companyData = json.decode(data.companySnapshot) as Map<String, dynamic>;

    return contract_models.Contract(
      id: contractData['id'] as String,
      contractor: contractor_models.Contractor(
        id: contractorData['id'] as String,
        abbr: contractorData['abbr'] as String,
        fullName: contractorData['fullName'] as String,
        paymentInfo: contractorData['paymentInfo'] as String?,
        contractorInfo: contractorData['contractorInfo'] as String?,
        signature: contractorData['signature'] != null
            ? base64Decode(contractorData['signature'] as String)
            : null,
        createdAt: DateTime.parse(contractorData['createdAt'] as String),
        updatedAt: DateTime.parse(contractorData['updatedAt'] as String),
      ),
      company: company_models.Company(
        id: companyData['id'] as String,
        name: companyData['name'] as String,
        abbr: companyData['abbr'] as String,
        paymentWeeks: companyData['paymentWeeks'] as int,
        currencyPrefix: companyData['currencyPrefix'] as String?,
        companyInfo: companyData['companyInfo'] as String?,
        updatedAt: DateTime.parse(companyData['updatedAt'] as String),
      ),
      date: DateTime.parse(contractData['date'] as String),
      fixed: contractData['fixed'] as bool,
      defaultPrice: contractData['defaultPrice'] as double?,
      showPeriod: contractData['showPeriod'] as bool,
      qtyLabel: contractData['qtyLabel'] as String?,
      priceLabel: contractData['priceLabel'] as String?,
      descriptionLabel: contractData['descriptionLabel'] as String?,
      amountLabel: contractData['amountLabel'] as String?,
      periodLabel: contractData['periodLabel'] as String?,
      totalLabel: contractData['totalLabel'] as String?,
      dueDateLabel: contractData['dueDateLabel'] as String?,
      dateLabel: contractData['dateLabel'] as String?,
      invoiceIdLbl: contractData['invoiceIdLbl'] as String?,
      invoiceTitle: contractData['invoiceTitle'] as String?,
      description: contractData['description'] as String?,
      contractorRoleSublabel: contractData['contractorRoleSublabel'] as String?,
      footnote: contractData['footnote'] as String?,
      contractorAgreementLabel: contractData['contractorAgreementLabel'] as String?,
      locale: contractData['locale'] as String?,
    );
  }

  invoice_item_models.InvoiceItem _itemToModel(db.DbInvoiceItem data) {
    return invoice_item_models.InvoiceItem(
      id: data.id,
      description: data.description,
      period: data.period,
      quantity: data.quantity,
      price: data.price,
      amount: data.amount,
    );
  }
}
