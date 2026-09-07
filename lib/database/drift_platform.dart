// Web implementation - uses WebDatabase (IndexedDB)
import 'package:drift/drift.dart';
import 'package:drift/web.dart';

LazyDatabase webDatabase(String name) {
  return LazyDatabase(() async {
    return WebDatabase.withStorage(
      await DriftWebStorage.indexedDbIfSupported(name),
    );
  });
}

LazyDatabase nativeDatabase(String path) {
  throw UnimplementedError('Native database not available on web');
}
