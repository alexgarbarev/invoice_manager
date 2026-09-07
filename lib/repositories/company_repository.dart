import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice_manager/repositories/app_repository.dart';

import '../database/app_database.dart' as db;
import '../database/app_database.dart' show AppDatabase;
import '../models/company.dart' as models;
import 'entity_repository.dart';

class CompanyRepository extends ChangeNotifier
    implements EntityRepository<models.Company>, RepositoryManualNotifier {
  final AppDatabase _db;

  CompanyRepository(this._db);

  @override
  Future<List<models.Company>> getAll() async {
    final companies = await _db.select(_db.dbCompanies).get();
    return companies.map(_toModel).toList();
  }

  @override
  Future<models.Company?> getById(String id) async {
    final company = await (_db.select(
      _db.dbCompanies,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
    return company != null ? _toModel(company) : null;
  }

  @override
  Future<void> save(models.Company company) async {
    await _db
        .into(_db.dbCompanies)
        .insert(
          _toTable(company),
          mode: InsertMode.insertOrReplace,
        );
    notifyListeners();
  }

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.dbCompanies)..where((c) => c.id.equals(id))).go();
    notifyListeners();
  }

  db.DbCompany _toTable(models.Company company) {
    return db.DbCompany(
      id: company.id,
      name: company.name,
      abbr: company.abbr,
      paymentWeeks: company.paymentWeeks,
      currencyPrefix: company.currencyPrefix,
      companyInfo: company.companyInfo,
      updatedAt: company.updatedAt,
    );
  }

  models.Company _toModel(db.DbCompany data) {
    return models.Company(
      id: data.id,
      name: data.name,
      abbr: data.abbr,
      paymentWeeks: data.paymentWeeks,
      currencyPrefix: data.currencyPrefix,
      companyInfo: data.companyInfo,
      updatedAt: data.updatedAt,
    );
  }

  @override
  void notifyAfterImport() {
    notifyListeners();
  }
}
