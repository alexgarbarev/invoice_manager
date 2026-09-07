import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_manager/repositories/entity_repository.dart';
import 'package:invoice_manager/repositories/in_memory_repository.dart';
import 'package:invoice_manager/widgets/builders/entity_list_builder.dart';

class FormField extends StatelessWidget {
  final String label;
  final Widget child;
  final double height;
  final bool showLabel;

  const FormField({
    super.key,
    this.showLabel = true,
    required this.label,
    required this.child,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: showLabel ? height : height - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showLabel) ...[
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
            ),
            const SizedBox(height: 4),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }
}

class StringTextField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLines;
  final void Function(String)? onChanged;
  final bool showLabel;

  const StringTextField({
    super.key,
    required this.label,
    this.controller,
    this.validator,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      label: label,
      showLabel: showLabel,
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }
}

class DateField extends StatelessWidget {
  final String label;
  final DateTime value;
  final VoidCallback onTap;

  const DateField({super.key, required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMMM yyyy');

    return HoverBuilder(
      builder: (context, isHovering) {
        return FormField(
          label: label,
          height: 56,
          child: GestureDetector(
            onTap: onTap,
            child: InputDecorator(
              isHovering: isHovering,
              decoration: InputDecoration(),
              isEmpty: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      dateFormat.format(value),

                      /// Same theme as default for TextFormField
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.calendar_today, color: Colors.grey, size: 18),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SelectField<T> extends StatelessWidget {
  final String label;
  final List<T>? items;
  final EntityRepository<T>? itemsRepository;
  final String Function(T) displayBuilder;
  final void Function(T?)? onChanged;
  final bool Function(T)? isSelected;
  final T? value;

  const SelectField({
    super.key,
    required this.label,
    this.isSelected,
    this.value,
    this.items,
    this.itemsRepository,
    required this.displayBuilder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    assert(items != null || itemsRepository != null, 'Either items or itemsRepository must be set');
    assert(items == null || itemsRepository == null, 'Either items or itemsRepository must be set');

    if (items != null) {
      return fieldForItems(items!);
    } else {
      return EntityListBuilder(
        repository: itemsRepository!,
        builder: (context, state, data) {
          if (state.isDone) {
            return fieldForItems(data!);
          } else {
            return CircularProgressIndicator();
          }
        },
      );
    }
  }

  FormField fieldForItems(List<T> items) {
    final selectedValue =
        value ?? (isSelected != null ? items.firstWhereOrNull(isSelected!) : null);

    final isIdentifiable = items.every((t) => t is Identifiable);

    dynamic valueFromItem(T? item) {
      if (item == null) return null;
      if (isIdentifiable) {
        return (item as Identifiable).id;
      }
      return item;
    }

    T itemFromValue(dynamic value) {
      if (isIdentifiable && value is String) {
        return items.firstWhere((i) => (i as Identifiable).id == value);
      }
      return value as T;
    }

    return FormField(
      label: label,
      height: 56,
      child: DropdownButtonFormField(
        initialValue: valueFromItem(selectedValue),
        items: items.map((item) {
          return DropdownMenuItem(value: valueFromItem(item), child: Text(displayBuilder(item)));
        }).toList(),
        onChanged: (changed) {
          onChanged?.call(itemFromValue(changed));
        },
      ),
    );
  }
}

class HoverBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, bool isHovering) builder;

  const HoverBuilder({super.key, required this.builder});

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        if (!isHovering) {
          setState(() {
            isHovering = true;
          });
        }
      },
      onExit: (_) {
        if (isHovering) {
          setState(() {
            isHovering = false;
          });
        }
      },
      onHover: (_) {
        if (!isHovering) {
          setState(() {
            isHovering = true;
          });
        }
      },
      child: widget.builder(context, isHovering),
    );
  }
}
