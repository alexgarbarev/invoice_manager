import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice_manager/repositories/app_repository.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'form_fields.dart';
import 'invoice_item_row.dart';

class InvoiceFormModal extends StatefulWidget {
  final Invoice? existingInvoice;

  const InvoiceFormModal({super.key, this.existingInvoice});

  @override
  State<InvoiceFormModal> createState() => _InvoiceFormModalState();
}

class _InvoiceFormModalState extends State<InvoiceFormModal> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  late DateTime _dueDate;
  Contract? _selectedContract;
  List<InvoiceItem> _items = [];
  InvoiceStatus _status = InvoiceStatus.draft;

  @override
  void initState() {
    super.initState();
    if (widget.existingInvoice != null) {
      final invoice = widget.existingInvoice!;
      _date = invoice.date;
      _dueDate = invoice.dueDate;
      _items = List.from(invoice.items);
      _status = invoice.status;
    } else {
      _date = DateTime.now();
      _dueDate = DateTime.now().add(const Duration(days: 21));
    }

    if (widget.existingInvoice != null) {
      _selectedContract = widget.existingInvoice!.contract;
    }
  }

  String get _generatedId {
    if (widget.existingInvoice != null) {
      return widget.existingInvoice!.displayId;
    }
    return Invoice.generateDisplayId(_selectedContract!, _date);
  }

  void _addItem() {
    setState(() {
      _items = List.from(_items)
        ..add(
          makeNewItem(),
        );
    });
  }

  InvoiceItem makeNewItem() {
    return InvoiceItem(
      id: InvoiceItem.generateId(),
      description: '',
      quantity: 1,
      price: _selectedContract?.defaultPrice ?? 0.0,
      period: DateFormat('MMMM yyyy', _selectedContract?.locale).format(_date),
      amount: null,
    );
  }

  void _updateItem(int index, InvoiceItem updatedItem) {
    setState(() {
      _items[index] = updatedItem;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items = List.from(_items)..removeAt(index);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
        _dueDate = picked.add(const Duration(days: 21));
      });
    }
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _saveInvoice() async {
    if (_formKey.currentState!.validate() && _selectedContract != null && _items.isNotEmpty) {
      final hasValidItems = _items.any((item) => item.description.isNotEmpty);
      if (!hasValidItems) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please add at least one valid item')),
          );
        }
        return;
      }
      final invoice = Invoice.create(
        id: widget.existingInvoice?.id,
        contract: _selectedContract!,
        date: _date,
        dueDate: _dueDate,
        items: _items,
        status: _status,
      );
      await context.read<AppRepository>().invoices.save(invoice);
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invoice saved successfully')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppRepository>();

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.existingInvoice == null ? 'Create Invoice' : 'Edit Invoice',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _selectedContract != null ? 'ID: $_generatedId' : '',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SelectField<Contract>(
                    label: 'Contract',
                    value: _selectedContract,
                    itemsRepository: provider.contracts,
                    displayBuilder: (c) => c.displayId,
                    onChanged: (value) async {
                      setState(() {
                        _selectedContract = value;
                        if (widget.existingInvoice == null && _items.isEmpty) {
                          _items.add(makeNewItem());
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: DateField(
                          label: 'Date',
                          value: _date,
                          onTap: () => _selectDate(context),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DateField(
                          label: 'Due Date',
                          value: _dueDate,
                          onTap: () => _selectDueDate(context),
                        ),
                      ),
                    ],
                  ),
                  if (widget.existingInvoice != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: SelectField<InvoiceStatus>(
                            label: 'Status',
                            value: _status,
                            items: InvoiceStatus.values,
                            displayBuilder: (s) => s.name.toUpperCase(),
                            onChanged: (value) {
                              setState(() {
                                _status = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  if (_selectedContract != null) ...[
                    const Text(
                      'Invoice Items',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (_selectedContract != null)
                    Column(
                      children: [
                        ...List.generate(
                          _items.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: InvoiceItemRow(
                              showLabels: index == 0,
                              item: _items[index],
                              contract: _selectedContract!,
                              date: _date,
                              onUpdate: (updatedItem) => _updateItem(index, updatedItem),
                              onDelete: () => _removeItem(index),
                            ),
                          ),
                        ),
                      ],
                    ),

                  // if (_items.isNotEmpty) const SizedBox(height: 12),
                  if (_selectedContract != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: _addItem,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Add'),
                          // style: TextButton.styleFrom(foregroundColor: Colors.blue),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      if (_items.isNotEmpty)
                        Text(
                          'Total: \$${_items.fold(0.0, (sum, item) => sum + item.totalAmount).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      Expanded(child: Container()),
                      ElevatedButton(
                        onPressed: _saveInvoice,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
