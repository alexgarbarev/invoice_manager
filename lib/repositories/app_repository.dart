import 'package:invoice_manager/database/app_database.dart';
import 'package:invoice_manager/repositories/in_memory_repository.dart';

import '../models/company.dart';
import '../models/contract.dart';
import '../models/contractor.dart';
import '../models/invoice.dart';
import 'company_repository.dart';
import 'contract_repository.dart';
import 'contractor_repository.dart';
import 'entity_repository.dart';
import 'invoice_deps_check_repository.dart';
import 'invoice_repository.dart';

class AppRepository {
  AppDatabase? _db;
  late final EntityRepository<Contractor> _contractors;
  late final EntityRepository<Company> _companies;
  late final EntityRepository<Contract> _contracts;
  late final EntityRepository<Invoice> _invoices;

  AppRepository({bool inMemory = false}) {
    if (inMemory) {
      _contractors = InMemoryRepository<Contractor>();
      _companies = InMemoryRepository<Company>();
      _contracts = InMemoryRepository<Contract>();
      _invoices = InvoiceDepsCheckRepository(
        InMemoryRepository<Invoice>(),
        _companies,
        _contractors,
        _contracts,
      );
    } else {
      _db = AppDatabase();
      final contractors = ContractorRepository(_db!);
      final companies = CompanyRepository(_db!);
      final contracts = ContractRepository(_db!, contractors, companies);
      _invoices = InvoiceDepsCheckRepository(
        InvoiceRepository(_db!),
        companies,
        contractors,
        contracts,
      );
      _contractors = contractors;
      _companies = companies;
      _contracts = contracts;
    }
  }

  AppDatabase get database => _db!;

  EntityRepository<Contractor> get contractors => _contractors;

  EntityRepository<Company> get companies => _companies;

  EntityRepository<Contract> get contracts => _contracts;

  EntityRepository<Invoice> get invoices => _invoices;

  Future<void> dispose() async {
    await _db?.close();
  }

  void notifyAfterImport() {
    for (final repo in [contracts, companies, contractors, invoices]) {
      if (repo is RepositoryManualNotifier) {
        (repo as RepositoryManualNotifier).notifyAfterImport();
      }
    }
  }
}

abstract class RepositoryManualNotifier {
  void notifyAfterImport();
}
