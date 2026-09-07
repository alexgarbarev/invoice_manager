import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:invoice_manager/repositories/app_repository.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'entity_list_widget.dart';
import 'entity_row_widget.dart';
import 'form_fields.dart';
import 'text_multiline_field.dart';

class ContractorsManagementModal extends StatefulWidget {
  const ContractorsManagementModal({super.key});

  @override
  State<ContractorsManagementModal> createState() => _ContractorsManagementModalState();
}

class _ContractorsManagementModalState extends State<ContractorsManagementModal> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedId;
  final _nameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _paymentInfoController = TextEditingController();
  final _contractorInfoController = TextEditingController();
  Uint8List? _signatureBytes;

  @override
  void dispose() {
    _nameController.dispose();
    _fullNameController.dispose();
    _paymentInfoController.dispose();
    _contractorInfoController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _selectedId = null;
    _nameController.clear();
    _fullNameController.clear();
    _paymentInfoController.clear();
    _contractorInfoController.clear();
    _signatureBytes = null;
  }

  void _selectContractor(Contractor contractor) {
    setState(() {
      _selectedId = contractor.id;
      _nameController.text = contractor.abbr;
      _fullNameController.text = contractor.fullName;
      _paymentInfoController.text = contractor.paymentInfo ?? '';
      _contractorInfoController.text = contractor.contractorInfo ?? '';
      _signatureBytes = contractor.signature;
    });
  }

  Future<void> _saveContractor() async {
    if (_formKey.currentState!.validate()) {
      final contractor = Contractor(
        id: _selectedId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        abbr: _nameController.text,
        fullName: _fullNameController.text,
        paymentInfo: _paymentInfoController.text.isEmpty ? null : _paymentInfoController.text,
        contractorInfo: _contractorInfoController.text.isEmpty
            ? null
            : _contractorInfoController.text,
        signature: _signatureBytes,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await context.read<AppRepository>().contractors.save(contractor);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Contractor ${contractor.abbr} saved')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AppRepository>().contractors;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: EntityListWidget<Contractor>(
            title: 'Contractor',
            entitiesRepo: repo,
            itemBuilder: (context, contractor) {
              return EntityRowWidget<Contractor>(
                entity: contractor,
                isSelected: _selectedId == contractor.id,
                onTap: () => _selectContractor(contractor),
                onDelete: () async {
                  await context.read<AppRepository>().contractors.delete(contractor.id);
                  if (_selectedId == contractor.id) {
                    setState(() {
                      _clearForm();
                      _selectedId = null;
                    });
                  }
                },
                titleBuilder: (c) => c.fullName,
                descriptionBuilder: (c) => c.abbr,
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
          child: _selectedId != null ? buildForm() : Center(child: const Text('Select contractor')),
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
                    'Contractor Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  StringTextField(
                    label: 'Full Name',
                    controller: _fullNameController,
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  StringTextField(
                    label: 'Abbreviation (for ID)',
                    controller: _nameController,
                    validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                  ),
                  const SizedBox(height: 12),
                  TextMultilineField(
                    label: 'Contractor Info (Markdown)',
                    controller: _contractorInfoController,
                    minLines: 5,
                  ),
                  const SizedBox(height: 12),
                  TextMultilineField(
                    label: 'Payment Info (Markdown)',
                    controller: _paymentInfoController,
                    minLines: 4,
                  ),
                  const SizedBox(height: 12),
                  InputDecorator(
                    decoration: InputDecoration(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Signature', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          if (_signatureBytes != null)
                            Image.memory(_signatureBytes!, height: 60)
                          else
                            const Text('No signature loaded'),
                          const SizedBox(height: 8),
                          TextButton.icon(
                            onPressed: () async {
                              final file = await FilePicker.pickFile(type: .image);

                              if (file != null) {
                                final bytes = await file.readAsBytes();
                                setState(() {
                                  _signatureBytes = bytes;
                                });
                                print(file.name);
                              } else {
                                // User canceled the picker
                              }
                            },
                            icon: const Icon(Icons.upload_file, size: 18),
                            label: const Text('Upload Signature'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0) - .only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _saveContractor,
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
