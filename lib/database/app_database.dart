import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:invoice_manager/database/database.dart';
import 'package:invoice_manager/database/drift_platform.dart'
    if (dart.library.io) 'drift_platform_io.dart'
    as platform;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    DbContractors,
    DbCompanies,
    DbContracts,
    DbInvoices,
    DbInvoiceItems,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        // Future migrations here
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    if (kIsWeb) {
      return platform.webDatabase('invoice_manager');
    }
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbPath = path.join(dbFolder.path, 'invoice_manager.sqlite');
    return platform.nativeDatabase(dbPath);
  });
}
