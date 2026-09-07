import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice_manager/repositories/app_repository.dart';

import '../database/app_database.dart' as db;
import '../database/app_database.dart' show AppDatabase;
import '../models/contract.dart' as models;
import 'company_repository.dart';
import 'contractor_repository.dart';
import 'entity_repository.dart';

class ContractRepository extends ChangeNotifier
    implements EntityRepository<models.Contract>, RepositoryManualNotifier {
  final AppDatabase _db;
  final ContractorRepository _contractors;
  final CompanyRepository _companies;

  ContractRepository(this._db, this._contractors, this._companies);

  @override
  Future<List<models.Contract>> getAll() async {
    final contracts = await _db.select(_db.dbContracts).get();

    final result = <models.Contract>[];
    for (final contract in contracts) {
      final contractModel = await _toModel(contract);
      if (contractModel != null) {
        result.add(contractModel);
      }
    }
    return result;
  }

  @override
  Future<models.Contract?> getById(String id) async {
    final contract = await (_db.select(
      _db.dbContracts,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
    return contract != null ? _toModel(contract) : null;
  }

  @override
  Future<void> save(models.Contract contract) async {
    await _db
        .into(_db.dbContracts)
        .insert(
          _toTable(contract),
          mode: InsertMode.insertOrReplace,
        );
    notifyListeners();
  }

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.dbContracts)..where((c) => c.id.equals(id))).go();
    notifyListeners();
  }

  db.DbContract _toTable(models.Contract contract) {
    return db.DbContract(
      id: contract.id,
      contractorId: contract.contractor.id,
      companyId: contract.company.id,
      date: contract.date,
      fixed: contract.fixed,
      defaultPrice: contract.defaultPrice,
      showPeriod: contract.showPeriod,
      qtyLabel: contract.qtyLabel,
      priceLabel: contract.priceLabel,
      descriptionLabel: contract.descriptionLabel,
      amountLabel: contract.amountLabel,
      periodLabel: contract.periodLabel,
      totalLabel: contract.totalLabel,
      dueDateLabel: contract.dueDateLabel,
      dateLabel: contract.dateLabel,
      invoiceIdLbl: contract.invoiceIdLbl,
      invoiceTitle: contract.invoiceTitle,
      description: contract.description,
      contractorRoleSublabel: contract.contractorRoleSublabel,
      footnote: contract.footnote,
      contractorAgreementLabel: contract.contractorAgreementLabel,
      locale: contract.locale,
    );
  }

  Future<models.Contract?> _toModel(db.DbContract data) async {
    final contractor = await _contractors.getById(data.contractorId);
    final company = await _companies.getById(data.companyId);

    if (contractor == null || company == null) {
      return null;
    }

    return models.Contract(
      id: data.id,
      contractor: contractor,
      company: company,
      date: data.date,
      fixed: data.fixed,
      defaultPrice: data.defaultPrice,
      showPeriod: data.showPeriod,
      qtyLabel: data.qtyLabel,
      priceLabel: data.priceLabel,
      descriptionLabel: data.descriptionLabel,
      amountLabel: data.amountLabel,
      periodLabel: data.periodLabel,
      totalLabel: data.totalLabel,
      dueDateLabel: data.dueDateLabel,
      dateLabel: data.dateLabel,
      invoiceIdLbl: data.invoiceIdLbl,
      invoiceTitle: data.invoiceTitle,
      description: data.description,
      contractorRoleSublabel: data.contractorRoleSublabel,
      footnote: data.footnote,
      contractorAgreementLabel: data.contractorAgreementLabel,
      locale: data.locale,
    );
  }

  @override
  void notifyAfterImport() {
    notifyListeners();
  }
}
