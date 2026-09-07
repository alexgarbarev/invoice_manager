import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:invoice_manager/repositories/app_repository.dart';
import 'package:invoice_manager/widgets/builders/entity_one_builder.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../services/invoice_pdf_service.dart';
import 'invoice_form_modal.dart';

class InvoiceDetailsPanel extends StatelessWidget {
  final String? invoiceId;

  const InvoiceDetailsPanel({super.key, this.invoiceId});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppRepository>().invoices;

    if (invoiceId == null) {
      return const Center(child: Text('Select an invoice to view details'));
    }

    return EntityOneBuilder(
      entityId: invoiceId!,
      repository: provider,
      builder: (context, state, data) {
        if (!state.isDone) {
          if (state.isFailed) {
            return Text(state.error.toString());
          }
          return const CircularProgressIndicator();
        }
        final invoice = data!;
        final contract = invoice.contract;

        final dateFormat = DateFormat('dd MMMM yyyy', contract.locale);

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == .light ? Colors.white : Colors.black54,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Invoice Details',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          if (invoice.hasOutdatedRefs)
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(color: Colors.yellow.withAlpha(70)),
                                  color: Colors.yellow.withAlpha(10),
                                ),
                                padding: const .symmetric(horizontal: 8, vertical: 2),
                                child: Row(
                                  spacing: 8,
                                  children: [
                                    Text(invoice.outdatedText),
                                    TextButton(
                                      style: OutlinedButton.styleFrom(padding: const .all(4)),
                                      onPressed: () => refresh(context),
                                      child: const Text('Refresh'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Expanded(child: Container()),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.picture_as_pdf),
                                onPressed: () => _exportPdf(context, invoice),
                                tooltip: 'Export PDF',
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showEditInvoiceModal(context, invoice),
                                tooltip: 'Edit',
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteInvoice(context, invoice),
                                tooltip: 'Delete',
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: .start,
                        children: [
                          _buildInvoiceInfoRow(contract.invoiceIdLabelOrDefault, invoice.displayId),
                          _buildInvoiceInfoRow(
                            contract.dateLabelOrDefault,
                            dateFormat.format(invoice.date),
                          ),
                          _buildInvoiceInfoRow(
                            contract.dueDateLabelOrDefault,
                            dateFormat.format(invoice.dueDate),
                          ),
                          _buildInvoiceInfoRow(
                            'Status',
                            invoice.status.name.toUpperCase(),
                            valueColor: _getStatusColor(invoice.status),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _buildSection(
                          context,
                          child: _buildContractorInfo(contract.contractor),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: _buildSection(
                          context,
                          child: _buildCompanyInfo(contract.company),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildItemsTable(context, invoice, contract),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: .end,
                      children: [
                        Text(
                          '${contract.totalLabelOrDefault}: \$${invoice.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  if (contract.contractor.paymentInfo != null)
                    ...makeMarkdownWidgets(contract.contractor.paymentInfo!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> refresh(BuildContext context) async {
    final provider = context.read<AppRepository>();

    final invoice = (await provider.invoices.getById(invoiceId!))!;

    final contract = (await provider.contracts.getById(invoice.contract.id))!;
    final contractor = (await provider.contractors.getById(contract.contractor.id))!;
    final company = (await provider.companies.getById(contract.company.id))!;

    final refreshedContract = contract.copyWith(contractor: contractor, company: company);
    await provider.contracts.save(refreshedContract);

    final refreshed = await invoice.copyWith(contract: refreshedContract);
    await provider.invoices.save(refreshed);
  }

  Widget _buildInvoiceInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: .min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(color: Colors.grey[700]),
          ),
          Text(
            '$value',
            style: valueColor != null
                ? TextStyle(color: valueColor)
                : TextStyle(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required Widget child}) {
    final color = Theme.of(context).brightness == .light ? Colors.grey[50] : Colors.grey[850];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: child,
    );
  }

  Iterable<Widget> makeMarkdownWidgets(String text) {
    return text.split('\n').map((line) {
      return MarkdownBody(data: line, selectable: true);
    });
  }

  Widget _buildContractorInfo(Contractor contractor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          contractor.fullName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 12),
        if (contractor.contractorInfo != null) ...[
          const SizedBox(height: 4),
          ...makeMarkdownWidgets(contractor.contractorInfo!),
        ],
        if (contractor.signature != null)
          Row(
            children: [
              const Text('Signature: ', style: const TextStyle(fontWeight: FontWeight.bold)),
              Image.memory(contractor.signature!, height: 60),
            ],
          ),
      ],
    );
  }

  Widget _buildCompanyInfo(Company company) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(company.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        if (company.companyInfo != null) ...[
          const SizedBox(height: 4),
          ...makeMarkdownWidgets(company.companyInfo!),
        ],
      ],
    );
  }

  Widget _buildItemsTable(BuildContext context, Invoice invoice, Contract contract) {
    if (invoice.items.isEmpty) {
      return const Text('No items');
    }

    final showPeriod = contract.showPeriod;
    final isFixed = contract.fixed;

    return Table(
      border: TableBorder.all(
        color: Theme.of(context).brightness == .light ? Colors.black : Colors.grey[800]!,
      ),
      columnWidths: isFixed
          ? {
              0: const FlexColumnWidth(3),
              1: const FlexColumnWidth(1),
            }
          : (showPeriod
                ? {
                    0: const FlexColumnWidth(2),
                    1: const FlexColumnWidth(1),
                    2: const FlexColumnWidth(0.5),
                    3: const FlexColumnWidth(1),
                  }
                : {
                    0: const FlexColumnWidth(2),
                    1: const FlexColumnWidth(0.5),
                    2: const FlexColumnWidth(1),
                  }),
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                contract.descriptionLabelOrDefault,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            if (showPeriod)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  contract.periodLabelOrDefault,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            if (!isFixed) ...[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  contract.qtyLabelOrDefault,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  contract.priceLabelOrDefault,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                contract.amountLabelOrDefault,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ...invoice.items.map((item) {
          return TableRow(
            children: [
              Padding(padding: const EdgeInsets.all(8), child: Text(item.description)),
              if (showPeriod)
                Padding(padding: const EdgeInsets.all(8), child: Text(item.period ?? '')),
              if (!isFixed)
                Padding(padding: const EdgeInsets.all(8), child: Text('${item.quantity}')),
              if (!isFixed)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('\$${item.price.toStringAsFixed(2)}'),
                ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text('\$${item.totalAmount.toStringAsFixed(2)}'),
              ),
            ],
          );
        }),
      ],
    );
  }

  Color? _getStatusColor(InvoiceStatus status) {
    switch (status) {
      case InvoiceStatus.draft:
        return Colors.grey;
      case InvoiceStatus.sent:
        return Colors.orange;
      case InvoiceStatus.paid:
        return Colors.green;
      case InvoiceStatus.cancelled:
        return Colors.red;
    }
  }

  void _showEditInvoiceModal(BuildContext context, Invoice invoice) {
    unawaited(
      showDialog(
        context: context,
        builder: (context) => InvoiceFormModal(existingInvoice: invoice),
      ),
    );
  }

  void _deleteInvoice(BuildContext context, Invoice invoice) {
    unawaited(
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Invoice'),
          content: Text('Are you sure you want to delete "${invoice.id}"?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            TextButton(
              onPressed: () {
                unawaited(context.read<AppRepository>().invoices.delete(invoice.id));
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exportPdf(BuildContext context, Invoice invoice) async {
    try {
      await InvoicePdfService.exportInvoicePdf(invoice, context.read<AppRepository>());
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text('PDF downloaded: ${invoice.displayId}.pdf'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(content: Text('Error exporting PDF: $e'), backgroundColor: Colors.red),
      );
    }
  }
}
