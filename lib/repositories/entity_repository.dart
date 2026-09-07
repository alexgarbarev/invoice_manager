import 'package:flutter/cupertino.dart';

abstract class EntityRepository<T> extends ChangeNotifier {
  Future<List<T>> getAll();

  Future<T?> getById(String id);

  Future<void> save(T entity);

  Future<void> delete(String id);
}
