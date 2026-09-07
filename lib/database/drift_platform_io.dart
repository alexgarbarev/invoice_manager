// Native (mobile/desktop) implementation - uses NativeDatabase with sqlite3
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';

LazyDatabase webDatabase(String name) {
  throw UnimplementedError('Web database not available on native platforms');
}

LazyDatabase nativeDatabase(String dbPath) {
  return LazyDatabase(() => NativeDatabase.createInBackground(File(dbPath)));
}

// Fallback for when a custom QueryExecutor is needed
LazyDatabase customNativeDatabase(QueryExecutor executor) {
  return LazyDatabase(() => executor);
}
