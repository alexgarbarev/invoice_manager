import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'entity_repository.dart';

class InMemoryRepository<T extends Identifiable> extends ChangeNotifier implements EntityRepository<T> {
  final Map<String, T> _data = {};

  @override
  Future<List<T>> getAll() async {
    return _data.values.toList();
  }

  @override
  Future<T?> getById(String id) async {
    return _data[id];
  }

  @override
  Future<void> save(T entity) async {
    _data[entity.id] = entity;
    notifyListeners();
  }

  @override
  Future<void> delete(String id) async {
    _data.remove(id);
    notifyListeners();
  }
}

abstract class Identifiable {
  String get id;
}
