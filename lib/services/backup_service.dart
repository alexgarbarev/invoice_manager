import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:drift/drift.dart' show Value, InsertMode;
import 'package:path/path.dart' as path;

import '../database/app_database.dart' as db;
import '../database/app_database.dart' show AppDatabase;

class BackupService {
  final AppDatabase _db;

  BackupService(this._db);

  Future<List<ArchiveFile>> exportData() async {
    final files = <ArchiveFile>[];

    final contractors = await _db.select(_db.dbContractors).get();
    for (final contractor in contractors) {
      final jsonData = <String, dynamic>{
        'id': contractor.id,
        'abbr': contractor.abbr,
        'fullName': contractor.fullName,
        'payment_info': contractor.paymentInfo,
        'contractor_info': contractor.contractorInfo,
        'signature': contractor.signature != null && contractor.signature!.isNotEmpty
            ? base64Encode(contractor.signature!)
            : null,
        'created_at': contractor.createdAt.toIso8601String(),
        'updated_at': contractor.updatedAt.toIso8601String(),
      };
      final jsonString = json.encode(jsonData);
      files.add(
        ArchiveFile(
          '${path.join('contractors', contractor.id)}.json',
          utf8.encode(jsonString).length,
          utf8.encode(jsonString),
        ),
      );
    }

    final companies = await _db.select(_db.dbCompanies).get();
    for (final company in companies) {
      final jsonData = <String, dynamic>{
        'id': company.id,
        'name': company.name,
        'abbr': company.abbr,
        'payment_weeks': company.paymentWeeks,
        'currency_prefix': company.currencyPrefix,
        'company_info': company.companyInfo,
        'updated_at': company.updatedAt.toIso8601String(),
      };
      final jsonString = json.encode(jsonData);
      files.add(
        ArchiveFile(
          '${path.join('companies', company.id)}.json',
          utf8.encode(jsonString).length,
          utf8.encode(jsonString),
        ),
      );
    }

    final contracts = await _db.select(_db.dbContracts).get();
    for (final contract in contracts) {
      final jsonData = <String, dynamic>{
        'id': contract.id,
        'contractor_id': contract.contractorId,
        'company_id': contract.companyId,
        'date': contract.date.toIso8601String(),
        'fixed': contract.fixed,
        'default_price': contract.defaultPrice,
        'show_period': contract.showPeriod,
        'qty_label': contract.qtyLabel,
        'price_label': contract.priceLabel,
        'description_label': contract.descriptionLabel,
        'amount_label': contract.amountLabel,
        'period_label': contract.periodLabel,
        'total_label': contract.totalLabel,
        'due_date_label': contract.dueDateLabel,
        'date_label': contract.dateLabel,
        'invoice_id_lbl': contract.invoiceIdLbl,
        'invoice_title': contract.invoiceTitle,
        'description': contract.description,
        'contractor_role_sublabel': contract.contractorRoleSublabel,
        'footnote': contract.footnote,
        'contractor_agreement_label': contract.contractorAgreementLabel,
        'locale': contract.locale,
      };
      final jsonString = json.encode(jsonData);
      files.add(
        ArchiveFile(
          '${path.join('contracts', contract.id)}.json',
          utf8.encode(jsonString).length,
          utf8.encode(jsonString),
        ),
      );
    }

    final invoices = await _db.select(_db.dbInvoices).get();
    print('Exporting ${invoices.length} invoices');
    for (final invoice in invoices) {
      print(
        '  Invoice: ${invoice.id}, contractSnapshot length: ${invoice.contractSnapshot.length}',
      );
      final jsonData = <String, dynamic>{
        'id': invoice.id,
        'date': invoice.date.toIso8601String(),
        'due_date': invoice.dueDate.toIso8601String(),
        'status': invoice.status,
        'contract_snapshot': invoice.contractSnapshot,
        'contractor_snapshot': invoice.contractorSnapshot,
        'company_snapshot': invoice.companySnapshot,
      };
      final jsonString = json.encode(jsonData);
      files.add(
        ArchiveFile(
          '${path.join('invoices', invoice.id)}.json',
          utf8.encode(jsonString).length,
          utf8.encode(jsonString),
        ),
      );
    }

    final invoiceItems = await _db.select(_db.dbInvoiceItems).get();
    for (final item in invoiceItems) {
      final jsonData = <String, dynamic>{
        'id': item.id,
        'invoice_id': item.invoiceId,
        'description': item.description,
        'period': item.period,
        'quantity': item.quantity,
        'price': item.price,
        'amount': item.amount,
      };
      final jsonString = json.encode(jsonData);
      files.add(
        ArchiveFile(
          '${path.join('invoice_items', item.id)}.json',
          utf8.encode(jsonString).length,
          utf8.encode(jsonString),
        ),
      );
    }

    return files;
  }

  Future<Uint8List> exportToZip() async {
    final files = await exportData();
    final archive = Archive();
    for (final file in files) {
      archive.addFile(file);
    }

    final zipEncoder = ZipEncoder();
    return zipEncoder.encode(archive) as Uint8List;
  }

  Future<void> importData(Uint8List zipData) async {
    print('Start importing ${zipData.length} bytes');
    final decoder = ZipDecoder();
    final archive = decoder.decodeBytes(zipData);

    int contractorsImported = 0;
    int companiesImported = 0;
    int contractsImported = 0;
    int invoicesImported = 0;
    int invoiceItemsImported = 0;
    int errors = 0;

    for (final file in archive.files) {
      if (file.isFile && file.content != null) {
        final content = file.content as List<int>;
        final contentStr = utf8.decode(content);
        final map = json.decode(contentStr) as Map<String, dynamic>;
        final fileName = file.name;

        if (fileName.endsWith('.json') && fileName.contains('contractors/')) {
          final signatureStr = map['signature'] as String?;
          final signatureBytes = signatureStr != null && signatureStr.isNotEmpty
              ? Uint8List.fromList(base64Decode(signatureStr))
              : null;

          await _db
              .into(_db.dbContractors)
              .insert(
                db.DbContractorsCompanion(
                  id: Value(map['id'] as String),
                  abbr: Value(map['abbr'] as String),
                  fullName: Value(map['fullName'] as String),
                  paymentInfo: map['payment_info'] != null
                      ? Value(map['payment_info'] as String)
                      : const Value<String>.absent(),
                  contractorInfo: map['contractor_info'] != null
                      ? Value(map['contractor_info'] as String)
                      : const Value<String>.absent(),
                  signature: signatureBytes != null
                      ? Value(signatureBytes)
                      : const Value<Uint8List>.absent(),
                  createdAt: Value(DateTime.parse(map['created_at'] as String)),
                  updatedAt: Value(DateTime.parse(map['updated_at'] as String)),
                ),
                mode: InsertMode.insertOrReplace,
              );
          contractorsImported++;
        } else if (fileName.endsWith('.json') && fileName.contains('companies/')) {
          await _db
              .into(_db.dbCompanies)
              .insert(
                db.DbCompaniesCompanion(
                  id: Value(map['id'] as String),
                  name: Value(map['name'] as String),
                  abbr: Value(map['abbr'] as String),
                  paymentWeeks: Value(map['payment_weeks'] as int),
                  currencyPrefix: map['currency_prefix'] != null
                      ? Value(map['currency_prefix'] as String)
                      : const Value<String>.absent(),
                  companyInfo: map['company_info'] != null
                      ? Value(map['company_info'] as String)
                      : const Value<String>.absent(),
                  updatedAt: Value(DateTime.parse(map['updated_at'] as String)),
                ),
                mode: InsertMode.insertOrReplace,
              );
          companiesImported++;
        } else if (fileName.endsWith('.json') && fileName.contains('contracts/')) {
          await _db
              .into(_db.dbContracts)
              .insert(
                db.DbContractsCompanion(
                  id: Value(map['id'] as String),
                  contractorId: Value(map['contractor_id'] as String),
                  companyId: Value(map['company_id'] as String),
                  date: Value(DateTime.parse(map['date'] as String)),
                  fixed: Value(map['fixed'] as bool),
                  defaultPrice: map['default_price'] != null
                      ? Value((map['default_price'] as num).toDouble())
                      : const Value<double>.absent(),
                  showPeriod: Value(map['show_period'] as bool),
                  qtyLabel: map['qty_label'] != null
                      ? Value(map['qty_label'] as String)
                      : const Value<String>.absent(),
                  priceLabel: map['price_label'] != null
                      ? Value(map['price_label'] as String)
                      : const Value<String>.absent(),
                  descriptionLabel: map['description_label'] != null
                      ? Value(map['description_label'] as String)
                      : const Value<String>.absent(),
                  amountLabel: map['amount_label'] != null
                      ? Value(map['amount_label'] as String)
                      : const Value<String>.absent(),
                  periodLabel: map['period_label'] != null
                      ? Value(map['period_label'] as String)
                      : const Value<String>.absent(),
                  totalLabel: map['total_label'] != null
                      ? Value(map['total_label'] as String)
                      : const Value<String>.absent(),
                  dueDateLabel: map['due_date_label'] != null
                      ? Value(map['due_date_label'] as String)
                      : const Value<String>.absent(),
                  dateLabel: map['date_label'] != null
                      ? Value(map['date_label'] as String)
                      : const Value<String>.absent(),
                  invoiceIdLbl: map['invoice_id_lbl'] != null
                      ? Value(map['invoice_id_lbl'] as String)
                      : const Value<String>.absent(),
                  invoiceTitle: map['invoice_title'] != null
                      ? Value(map['invoice_title'] as String)
                      : const Value<String>.absent(),
                  description: map['description'] != null
                      ? Value(map['description'] as String)
                      : const Value<String>.absent(),
                  contractorRoleSublabel: map['contractor_role_sublabel'] != null
                      ? Value(map['contractor_role_sublabel'] as String)
                      : const Value<String>.absent(),
                  footnote: map['footnote'] != null
                      ? Value(map['footnote'] as String)
                      : const Value<String>.absent(),
                  contractorAgreementLabel: map['contractor_agreement_label'] != null
                      ? Value(map['contractor_agreement_label'] as String)
                      : const Value<String>.absent(),
                  locale: map['locale'] != null
                      ? Value(map['locale'] as String)
                      : const Value<String>.absent(),
                ),
                mode: InsertMode.insertOrReplace,
              );
          contractsImported++;
        } else if (fileName.endsWith('.json') && fileName.contains('invoices/')) {
          try {
            final contractSnapshot = (map['contract_snapshot'] as String?) ?? '';
            final contractorSnapshot = (map['contractor_snapshot'] as String?) ?? '';
            final companySnapshot = (map['company_snapshot'] as String?) ?? '';

            await _db
                .into(_db.dbInvoices)
                .insert(
                  db.DbInvoicesCompanion(
                    id: Value(map['id'] as String),
                    date: Value(DateTime.parse(map['date'] as String)),
                    dueDate: Value(DateTime.parse(map['due_date'] as String)),
                    status: Value(map['status'] as int),
                    contractSnapshot: Value(contractSnapshot),
                    contractorSnapshot: Value(contractorSnapshot),
                    companySnapshot: Value(companySnapshot),
                  ),
                  mode: InsertMode.insertOrReplace,
                );
          } catch (e) {
            print('Error importing invoice ${map['id']}: $e');
          }
          invoicesImported++;
        } else if (fileName.endsWith('.json') && fileName.contains('invoice_items/')) {
          try {
            await _db
                .into(_db.dbInvoiceItems)
                .insert(
                  db.DbInvoiceItemsCompanion(
                    id: Value(map['id'] as String),
                    invoiceId: Value(map['invoice_id'] as String),
                    description: Value(map['description'] as String),
                    period: map['period'] != null
                        ? Value(map['period'] as String)
                        : const Value<String>.absent(),
                    quantity: Value(map['quantity'] as int),
                    price: Value(map['price'] as double),
                    amount: map['amount'] != null
                        ? Value(map['amount'] as double)
                        : const Value<double>.absent(),
                  ),
                  mode: InsertMode.insertOrReplace,
                );
          } catch (e) {
            print('Error importing invoice item ${map['id']}: $e');
            errors++;
            continue;
          }
          invoiceItemsImported++;
        } else {
          print('Skipping unknown file: $fileName');
        }
      }
    }

    print('Import completed:');
    print('  Contractors: $contractorsImported');
    print('  Companies: $companiesImported');
    print('  Contracts: $contractsImported');
    print('  Invoices: $invoicesImported');
    print('  Invoice Items: $invoiceItemsImported');
    print('  Errors: $errors');
  }
}
