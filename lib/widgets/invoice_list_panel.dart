import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_manager/repositories/app_repository.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'entity_list_widget.dart';
import 'entity_row_widget.dart';
import 'invoice_form_modal.dart';

class InvoiceListPanel extends StatelessWidget {
  final String? selectedInvoiceId;
  final void Function(String? selectedInvoiceId)? onSelect;

  const InvoiceListPanel({super.key, this.selectedInvoiceId, this.onSelect});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AppRepository>().invoices;

    return EntityListWidget<Invoice>(
      title: 'Invoice',
      entitiesRepo: repo,
      sorting: (a, b) => b.date.compareTo(a.date),
      itemBuilder: (context, invoice) {
        return EntityRowWidget<Invoice>(
          entity: invoice,
          isSelected: selectedInvoiceId == invoice.id,
          onTap: () => onSelect?.call(invoice.id),
          onDelete: () {
            unawaited(repo.delete(invoice.id));
            if (selectedInvoiceId == invoice.id) {
              onSelect?.call(null);
            }
          },
          onDuplicate: (invoice) {
            final duplicated = invoice.duplicate();
            unawaited(
              showDialog(
                context: context,
                builder: (context) => InvoiceFormModal(existingInvoice: duplicated),
              ),
            );
          },
          getInvoice: () => invoice,
          onStatusChange: (status) {
            final updated = invoice.copyWith(status: status);
            unawaited(repo.save(updated));
          },
          titleBuilder: (invoice) => invoice.displayId,
          descriptionBuilder: (invoice) {
            final dateFormat = DateFormat('dd MMM yyyy');
            final contract = invoice.contract;
            return '${dateFormat.format(invoice.date)} • ${contract.displayId}';
          },
        );
      },
      onDeselect: () => onSelect?.call(null),
      onCreate: () {
        unawaited(showDialog(context: context, builder: (context) => const InvoiceFormModal()));
      },
    );
  }
}
