import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice_manager/repositories/entity_repository.dart';
import 'package:invoice_manager/widgets/builders/entity_list_builder.dart';

typedef EntityBuilder<T> = Widget Function(BuildContext context, T entity);

class EntityListWidget<T> extends StatefulWidget {
  final String title;
  final EntityRepository<T> entitiesRepo;
  final EntityBuilder<T> itemBuilder;
  final VoidCallback onCreate;
  final VoidCallback onDeselect;

  final int Function(T a, T b)? sorting;

  const EntityListWidget({
    super.key,
    required this.title,
    required this.entitiesRepo,
    required this.itemBuilder,
    required this.onCreate,
    this.sorting,
    required this.onDeselect,
  });

  @override
  State<EntityListWidget<T>> createState() => _EntityListWidgetState<T>();
}

class _EntityListWidgetState<T> extends State<EntityListWidget<T>> {
  List<T>? entities;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _searchController.addListener(onSearchChanged);
    super.initState();
  }

  void onSearchChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<T> filter(List<T>? entities) {
    if (entities == null) return [];
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return entities;
    return entities.where((entity) {
      final searchable = _getSearchable(entity).toLowerCase();
      return searchable.contains(query);
    }).toList();
  }

  String _getSearchable(T entity) {
    if (entity is EntitySearchable) {
      return entity.searchDescription;
    }
    return entity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return EntityListBuilder(
      repository: widget.entitiesRepo,
      builder: (context, state, data) {
        if (!state.isDone) {
          return CircularProgressIndicator();
        }
        final entities = data!;
        final filtered = filter(entities);

        if (widget.sorting != null) {
          entities.sort(widget.sorting!);
        }

        return Column(
          crossAxisAlignment: .end,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: CupertinoSearchTextField(controller: _searchController),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              child: TextButton.icon(
                onPressed: widget.onCreate,
                icon: const Icon(Icons.add, size: 18),
                label: Text(
                  'Create ${widget.title}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Text(
                        entities.isEmpty ? 'No ${widget.title} yet' : 'No matches found',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  : GestureDetector(
                      onTap: widget.onDeselect,
                      child: ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final entity = filtered[index];
                          return widget.itemBuilder(context, entity);
                        },
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}

mixin EntitySearchable {
  String get searchDescription;
}
