import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice_manager/repositories/app_repository.dart';

import '../database/app_database.dart' as db;
import '../database/app_database.dart' show AppDatabase;
import '../models/contractor.dart' as models;
import 'entity_repository.dart';

class ContractorRepository extends ChangeNotifier
    implements EntityRepository<models.Contractor>, RepositoryManualNotifier {
  final AppDatabase _db;

  ContractorRepository(this._db);

  @override
  Future<List<models.Contractor>> getAll() async {
    final contractors = await _db.select(_db.dbContractors).get();
    return contractors.map(_toModel).toList();
  }

  @override
  Future<models.Contractor?> getById(String id) async {
    final contractor = await (_db.select(
      _db.dbContractors,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
    return contractor != null ? _toModel(contractor) : null;
  }

  @override
  Future<void> save(models.Contractor contractor) async {
    await _db
        .into(_db.dbContractors)
        .insert(
          _toTable(contractor),
          mode: InsertMode.insertOrReplace,
        );
    notifyListeners();
  }

  @override
  Future<void> delete(String id) async {
    await (_db.delete(_db.dbContractors)..where((c) => c.id.equals(id))).go();
    notifyListeners();
  }

  db.DbContractor _toTable(models.Contractor contractor) {
    return db.DbContractor(
      id: contractor.id,
      abbr: contractor.abbr,
      fullName: contractor.fullName,
      paymentInfo: contractor.paymentInfo,
      contractorInfo: contractor.contractorInfo,
      signature: contractor.signature,
      createdAt: contractor.createdAt,
      updatedAt: contractor.updatedAt,
    );
  }

  models.Contractor _toModel(db.DbContractor data) {
    return models.Contractor(
      id: data.id,
      abbr: data.abbr,
      fullName: data.fullName,
      paymentInfo: data.paymentInfo,
      contractorInfo: data.contractorInfo,
      signature: data.signature,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
    );
  }

  @override
  void notifyAfterImport() {
    notifyListeners();
  }
}
