import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import 'form_fields.dart';

class InvoiceItemRow extends StatefulWidget {
  final InvoiceItem item;
  final Contract contract;
  final DateTime date;
  final ValueChanged<InvoiceItem> onUpdate;
  final VoidCallback onDelete;
  final bool showLabels;

  const InvoiceItemRow({
    super.key,
    required this.item,
    required this.contract,
    required this.date,
    this.showLabels = true,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<InvoiceItemRow> createState() => _InvoiceItemRowState();
}

class _InvoiceItemRowState extends State<InvoiceItemRow> {
  final _descriptionController = TextEditingController();
  final _periodController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _amountController = TextEditingController();

  late DateFormat _dateFormat;

  @override
  void initState() {
    super.initState();
    _syncDateFormat();
    _descriptionController.text = widget.item.description;
    _periodController.text = widget.item.period ?? '';
    _quantityController.text = '${widget.item.quantity}';
    _priceController.text = '${widget.item.price}';
    _amountController.text = widget.item.amount != null ? '${widget.item.amount}' : '';
  }

  @override
  void didUpdateWidget(InvoiceItemRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.contract.locale != oldWidget.contract.locale) {
      _syncDateFormat();
    }
    if (widget.date != oldWidget.date || widget.contract.locale != oldWidget.contract.locale) {
      final oldPeriod = DateFormat('MMMM yyyy', oldWidget.contract.locale).format(oldWidget.date);
      final newPeriod = _dateFormat.format(widget.date);

      if (_periodController.text == oldPeriod) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _periodController.text = newPeriod;
          _syncWithParent();
        });
      }
    }
  }

  void _syncDateFormat() {
    _dateFormat = DateFormat('MMMM yyyy', widget.contract.locale);
  }

  void _syncWithParent() {
    final periodValue = _dateFormat.format(widget.date);
    final newItem = InvoiceItem(
      id: widget.item.id,
      description: _descriptionController.text,
      quantity: int.tryParse(_quantityController.text) ?? 1,
      price: double.tryParse(_priceController.text) ?? 0.0,
      period: _periodController.text.isEmpty ? periodValue : _periodController.text,
      amount: widget.contract.fixed ? (double.tryParse(_amountController.text)) : null,
    );
    widget.onUpdate(newItem);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _periodController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 8,
      children: [
        Expanded(
          flex: 3,
          child: StringTextField(
            showLabel: widget.showLabels,
            label: 'Description',
            controller: _descriptionController,
            onChanged: (_) => _syncWithParent(),
          ),
        ),
        if (widget.contract.showPeriod)
          Expanded(
            flex: 2,
            child: StringTextField(
              showLabel: widget.showLabels,
              label: 'Period',
              controller: _periodController,
              onChanged: (_) => _syncWithParent(),
            ),
          ),
        if (!widget.contract.fixed) ...[
          SizedBox(
            width: 70,
            child: StringTextField(
              showLabel: widget.showLabels,
              label: 'Qty',
              controller: _quantityController,
              keyboardType: TextInputType.number,
              onChanged: (_) => _syncWithParent(),
            ),
          ),
          SizedBox(
            width: 90,
            child: StringTextField(
              showLabel: widget.showLabels,
              label: 'Price',
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => _syncWithParent(),
            ),
          ),
        ] else ...[
          SizedBox(
            width: 120,
            child: StringTextField(
              showLabel: widget.showLabels,
              label: 'Amount',
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => _syncWithParent(),
            ),
          ),
        ],
        Container(
          padding: const EdgeInsets.only(bottom: 2),
          child: TextButton(
            onPressed: widget.onDelete,
            child: const Icon(Icons.delete, size: 18),
            style: TextButton.styleFrom(foregroundColor: Colors.grey, minimumSize: Size(0, 40)),
          ),
        ),
      ],
    );
  }
}
