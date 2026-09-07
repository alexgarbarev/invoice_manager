import 'dart:async';

import 'package:flutter/material.dart';

import '../models/models.dart';

class EntityRowWidget<T> extends StatelessWidget {
  final T entity;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final String Function(T)? titleBuilder;
  final String Function(T)? descriptionBuilder;
  final Invoice? Function()? getInvoice;
  final void Function(Invoice)? onDuplicate;
  final void Function(InvoiceStatus)? onStatusChange;

  const EntityRowWidget({
    super.key,
    required this.entity,
    required this.isSelected,
    required this.onTap,
    required this.onDelete,
    this.titleBuilder,
    this.descriptionBuilder,
    this.getInvoice,
    this.onDuplicate,
    this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final title = titleBuilder?.call(entity) ?? entity.toString();
    final description = descriptionBuilder?.call(entity) ?? '';
    final invoice = getInvoice?.call();

    final statusColors = {
      InvoiceStatus.draft: Colors.grey,
      InvoiceStatus.sent: Colors.orange,
      InvoiceStatus.paid: Colors.green,
      InvoiceStatus.cancelled: Colors.red,
    };

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary.withAlpha(10)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withAlpha(30)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          selected: isSelected,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          subtitle: description.isNotEmpty
              ? Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              : null,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              if (invoice != null && onStatusChange != null)
                InvoiceStatusButton(
                  onStatusChange: onStatusChange,
                  statusColors: statusColors,
                  invoice: invoice,
                ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, size: 18),
                onSelected: (value) {
                  if (value == 'delete') {
                    _showDeleteConfirmation(context, title);
                  }
                  if (value == 'duplicate') {
                    onDuplicate?.call(invoice!);
                  }
                },
                itemBuilder: (context) => [
                  if (invoice != null)
                    const PopupMenuItem(
                      value: 'duplicate',
                      child: Row(
                        children: [
                          Icon(Icons.copy, size: 20, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('Duplicate'),
                        ],
                      ),
                    ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline, size: 20, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String title) {
    unawaited(
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete'),
          content: Text('Are you sure you want to delete "$title"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDelete();
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceStatusButton extends StatelessWidget {
  const InvoiceStatusButton({
    super.key,
    required this.onStatusChange,
    required this.statusColors,
    required this.invoice,
  });

  final void Function(InvoiceStatus)? onStatusChange;
  final Map<InvoiceStatus, MaterialColor> statusColors;
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<InvoiceStatus>(
      onSelected: onStatusChange,
      borderRadius: BorderRadius.circular(12),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: InvoiceStatus.draft,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text('Draft'),
            ],
          ),
        ),
        PopupMenuItem(
          value: InvoiceStatus.sent,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text('Sent'),
            ],
          ),
        ),
        PopupMenuItem(
          value: InvoiceStatus.paid,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text('Paid'),
            ],
          ),
        ),
        PopupMenuItem(
          value: InvoiceStatus.cancelled,
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text('Cancelled'),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: statusColors[invoice.status]?.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: statusColors[invoice.status] ?? Colors.grey,
            width: 1,
          ),
        ),
        child: Text(
          invoice.status.name.toUpperCase(),
          style: TextStyle(
            fontSize: 11,
            color: statusColors[invoice.status],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
