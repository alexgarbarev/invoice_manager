import 'package:flutter/cupertino.dart';
import 'package:invoice_manager/models/contractor.dart';
import 'package:invoice_manager/repositories/entity_repository.dart';

import '../models/company.dart';
import '../models/contract.dart';
import '../models/invoice.dart';
import 'app_repository.dart';

class InvoiceDepsCheckRepository extends ChangeNotifier
    implements EntityRepository<Invoice>, RepositoryManualNotifier {
  EntityRepository<Invoice> _internal;
  EntityRepository<Contractor> _contractorRepo;
  EntityRepository<Company> _companyRepo;
  EntityRepository<Contract> _contractsRepo;

  InvoiceDepsCheckRepository(
    this._internal,
    this._companyRepo,
    this._contractorRepo,
    this._contractsRepo,
  ) {
    _internal.addListener(notifyListeners);
  }

  @override
  void dispose() {
    _internal.dispose();
    super.dispose();
  }

  @override
  Future<void> delete(String id) {
    return _internal.delete(id);
  }

  @override
  Future<List<Invoice>> getAll() {
    return _internal.getAll();
  }

  @override
  Future<Invoice?> getById(String id) async {
    // Let's only check when getting by id
    final invoice = await _internal.getById(id);

    if (invoice != null) {
      invoice.hasOutdatedContractor =
          await _contractorRepo.getById(invoice.contract.contractor.id) !=
          invoice.contract.contractor;

      invoice.hasOutdatedCompany =
          await _companyRepo.getById(invoice.contract.company.id) != invoice.contract.company;

      invoice.hasOutdatedContract =
          await _contractsRepo.getById(invoice.contract.id) != invoice.contract;
    }

    return invoice;
  }

  @override
  Future<void> save(Invoice entity) {
    return _internal.save(entity);
  }

  @override
  void notifyAfterImport() {
    notifyListeners();
  }
}
