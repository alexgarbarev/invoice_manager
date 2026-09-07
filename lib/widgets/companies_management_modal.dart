import 'package:flutter/material.dart';
import 'package:invoice_manager/repositories/app_repository.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'entity_list_widget.dart';
import 'entity_row_widget.dart';
import 'form_fields.dart';
import 'text_multiline_field.dart';

class CompaniesManagementModal extends StatefulWidget {
  const CompaniesManagementModal({super.key});

  @override
  State<CompaniesManagementModal> createState() => _CompaniesManagementModalState();
}

class _CompaniesManagementModalState extends State<CompaniesManagementModal> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedId;
  final _nameController = TextEditingController();
  final _abbrController = TextEditingController();
  final _currencyPrefixController = TextEditingController();
  final _companyInfoController = TextEditingController();
  int _paymentWeeks = 3;

  @override
  void dispose() {
    _nameController.dispose();
    _abbrController.dispose();
    _currencyPrefixController.dispose();
    _companyInfoController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _selectedId = null;
    _nameController.clear();
    _abbrController.clear();
    _currencyPrefixController.clear();
    _companyInfoController.clear();
    _paymentWeeks = 3;
  }

  void _selectCompany(Company company) {
    setState(() {
      _selectedId = company.id;
      _nameController.text = company.name;
      _abbrController.text = company.abbr;
      _currencyPrefixController.text = company.currencyPrefix ?? '';
      _companyInfoController.text = company.companyInfo ?? '';
      _paymentWeeks = company.paymentWeeks;
    });
  }

  Future<void> _saveCompany() async {
    if (_formKey.currentState!.validate()) {
      final company = Company(
        id: _selectedId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        abbr: _abbrController.text.toUpperCase(),
        paymentWeeks: _paymentWeeks,
        currencyPrefix: _currencyPrefixController.text.isEmpty
            ? null
            : _currencyPrefixController.text,
        companyInfo: _companyInfoController.text.isEmpty ? null : _companyInfoController.text,
        updatedAt: DateTime.now(),
      );
      await context.read<AppRepository>().companies.save(company);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Company ${company.name} saved')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AppRepository>().companies;

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: EntityListWidget<Company>(
            title: 'Company',
            entitiesRepo: repo,
            itemBuilder: (context, company) {
              return EntityRowWidget<Company>(
                entity: company,
                isSelected: _selectedId == company.id,
                onTap: () => _selectCompany(company),
                onDelete: () async {
                  await repo.delete(company.id);
                  if (_selectedId == company.id) {
                    setState(() {
                      _selectedId = null;
                    });
                  }
                },
                titleBuilder: (c) => c.name,
                descriptionBuilder: (c) => 'Abbreviation: ${c.abbr}',
              );
            },
            onDeselect: () => setState(() {
              _selectedId = null;
            }),
            onCreate: () {
              setState(() {
                _clearForm();
                _selectedId = DateTime.now().millisecondsSinceEpoch.toString();
              });
            },
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 2,
          child: _selectedId != null ? buildForm() : const Center(child: Text('Select company')),
        ),
      ],
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Company Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  StringTextField(
                    label: 'Company Name',
                    controller: _nameController,
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  StringTextField(
                    label: 'Abbreviation (for ID)',
                    controller: _abbrController,
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextMultilineField(
                    label: 'Company Info (Markdown)',
                    controller: _companyInfoController,
                    minLines: 5,
                  ),
                  const SizedBox(height: 12),
                  SelectField<int>(
                    value: _paymentWeeks,
                    items: const [1, 2, 3, 4, 6, 8],
                    label: 'Payment Terms (weeks)',
                    displayBuilder: (weeks) {
                      return '${weeks} week${weeks > 1 ? 's' : ''}';
                    },
                    onChanged: (weeks) {
                      _paymentWeeks = weeks ?? 3;
                    },
                  ),
                  const SizedBox(height: 12),
                  StringTextField(
                    label: 'Currency Prefix',
                    controller: _currencyPrefixController,
                  ),
                  Text(
                    'e.g. \$USD or \$',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _saveCompany,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
