import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:invoice_manager/repositories/entity_repository.dart';

import 'entity_builder_state.dart';

class EntityOneBuilder<T> extends StatefulWidget {
  final String entityId;
  final EntityRepository<T> repository;
  final Widget Function(BuildContext context, EntityBuilderState state, T? entity) builder;

  const EntityOneBuilder({
    super.key,
    required this.entityId,
    required this.repository,
    required this.builder,
  });

  @override
  State<EntityOneBuilder> createState() => _EntityOneBuilderState<T>();
}

class _EntityOneBuilderState<T> extends State<EntityOneBuilder<T>> {
  EntityBuilderState state = EntityBuilderState.done();
  T? entity;

  @override
  void initState() {
    unawaited(reloadEntity());
    widget.repository.addListener(reloadEntity);
    super.initState();
  }

  @override
  void didUpdateWidget(EntityOneBuilder<T> oldWidget) {
    if (oldWidget.entityId != widget.entityId || oldWidget.repository != widget.repository) {
      unawaited(reloadEntity());
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.repository.removeListener(reloadEntity);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, state, entity);
  }

  Future<void> reloadEntity() async {
    setState(() {
      state = EntityBuilderState.loading();
      entity = null;
    });
    try {
      entity = await widget.repository.getById(widget.entityId);
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
