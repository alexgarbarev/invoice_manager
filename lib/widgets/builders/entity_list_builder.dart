import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoice_manager/repositories/entity_repository.dart';

import 'entity_builder_state.dart';

typedef EntityListBuilderFn<T> =
    Widget Function(BuildContext context, EntityBuilderState state, List<T>? entity);

class EntityListBuilder<T> extends StatefulWidget {
  final EntityRepository<T> repository;
  final EntityListBuilderFn<T> builder;

  const EntityListBuilder({
    super.key,
    required this.repository,
    required this.builder,
  });

  @override
  State<EntityListBuilder> createState() => _EntityListBuilderState<T>();
}

class _EntityListBuilderState<T> extends State<EntityListBuilder<T>> {
  EntityBuilderState state = EntityBuilderState.done();
  List<T>? entities;

  @override
  void initState() {
    unawaited(reloadEntities());
    widget.repository.addListener(reloadEntities);
    super.initState();
  }

  @override
  void didUpdateWidget(EntityListBuilder<T> oldWidget) {
    if (oldWidget.repository != widget.repository) {
      unawaited(reloadEntities());
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.repository.removeListener(reloadEntities);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      state,
      entities,
    );
  }

  Future<void> reloadEntities() async {
    setState(() {
      state = EntityBuilderState.loading();
      entities = null;
    });
    try {
      entities = await widget.repository.getAll();
      setState(() {
        state = EntityBuilderState.done();
      });
    } catch (e) {
      setState(() {
        state = EntityBuilderState.failure(e);
      });
    }
  }
}
