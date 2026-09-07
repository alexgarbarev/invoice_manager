import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invoice_manager/repositories/app_repository.dart';
import 'package:invoice_manager/widgets/text_multiline_field.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import 'entity_list_widget.dart';
import 'entity_row_widget.dart';
import 'form_fields.dart';

class ContractManagementModal extends StatefulWidget {
  const ContractManagementModal({super.key});

  @override
  State<ContractManagementModal> createState() => _ContractManagementModalState();
}

class _ContractManagementModalState extends State<ContractManagementModal> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedId;
  DateTime _date = DateTime.now();
  bool _fixed = false;
  double? _defaultPrice;
  bool _showPeriod = true;
  bool _customizeLabels = false;

  Contractor? _selectedContractor;
  Company? _selectedCompany;

  String? _qtyLabel;
  String? _priceLabel;
  String? _descriptionLabel;
  String? _amountLabel;
  String? _periodLabel;
  String? _totalLabel;
  String? _dueDateLabel;
  String? _dateLabel;
  String? _invoiceIdLbl;
  String? _invoiceTitle;
  String? _description;
  String? _contractorRoleSublabel;
  String? _footnote;
  String? _contractorAgreementLabel;
  String? _locale;

  final _qtyLabelController = TextEditingController();
  final _priceLabelController = TextEditingController();
  final _descriptionLabelController = TextEditingController();
  final _amountLabelController = TextEditingController();
  final _periodLabelController = TextEditingController();
  final _totalLabelController = TextEditingController();
  final _dueDateLabelController = TextEditingController();
  final _dateLabelController = TextEditingController();
  final _invoiceIdLblController = TextEditingController();
  final _invoiceTitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contractorRoleSublabelController = TextEditingController();
  final _footnoteController = TextEditingController();
  final _contractorAgreementLabelController = TextEditingController();
  final _defaultPriceController = TextEditingController();

  static const _localeOptions = <_LocaleOption>[
    _LocaleOption('af', 'Afrikaans'),
    _LocaleOption('am', 'Amharic'),
    _LocaleOption('ar', 'Arabic'),
    _LocaleOption('as', 'Assamese'),
    _LocaleOption('az', 'Azerbaijani'),
    _LocaleOption('be', 'Belarusian'),
    _LocaleOption('bg', 'Bulgarian'),
    _LocaleOption('bn', 'Bengali Bangla'),
    _LocaleOption('bo', 'Tibetan'),
    _LocaleOption('bs', 'Bosnian'),
    _LocaleOption('ca', 'Catalan Valencian'),
    _LocaleOption('cs', 'Czech'),
    _LocaleOption('cy', 'Welsh'),
    _LocaleOption('da', 'Danish'),
    _LocaleOption('de', 'German'),
    _LocaleOption('el', 'Modern Greek'),
    _LocaleOption('en', 'English'),
    _LocaleOption('es', 'Spanish Castilian'),
    _LocaleOption('et', 'Estonian'),
    _LocaleOption('eu', 'Basque'),
    _LocaleOption('fa', 'Persian'),
    _LocaleOption('fi', 'Finnish'),
    _LocaleOption('fil', 'Filipino Pilipino'),
    _LocaleOption('fr', 'French'),
    _LocaleOption('ga', 'Irish'),
    _LocaleOption('gl', 'Galician'),
    _LocaleOption('gsw', 'Swiss German Alemannic Alsatian'),
    _LocaleOption('gu', 'Gujarati'),
    _LocaleOption('he', 'Hebrew'),
    _LocaleOption('hi', 'Hindi'),
    _LocaleOption('hr', 'Croatian'),
    _LocaleOption('hu', 'Hungarian'),
    _LocaleOption('hy', 'Armenian'),
    _LocaleOption('id', 'Indonesian'),
    _LocaleOption('is', 'Icelandic'),
    _LocaleOption('it', 'Italian'),
    _LocaleOption('ja', 'Japanese'),
    _LocaleOption('ka', 'Georgian'),
    _LocaleOption('kk', 'Kazakh'),
    _LocaleOption('km', 'Khmer Central Khmer'),
    _LocaleOption('kn', 'Kannada'),
    _LocaleOption('ko', 'Korean'),
    _LocaleOption('ky', 'Kirghiz Kyrgyz'),
    _LocaleOption('lo', 'Lao'),
    _LocaleOption('lt', 'Lithuanian'),
    _LocaleOption('lv', 'Latvian'),
    _LocaleOption('mk', 'Macedonian'),
    _LocaleOption('ml', 'Malayalam'),
    _LocaleOption('mn', 'Mongolian'),
    _LocaleOption('mr', 'Marathi'),
    _LocaleOption('ms', 'Malay'),
    _LocaleOption('my', 'Burmese'),
    _LocaleOption('nb', 'Norwegian Bokmål'),
    _LocaleOption('ne', 'Nepali'),
    _LocaleOption('nl', 'Dutch Flemish'),
    _LocaleOption('no', 'Norwegian'),
    _LocaleOption('or', 'Oriya'),
    _LocaleOption('pa', 'Panjabi Punjabi'),
    _LocaleOption('pl', 'Polish'),
    _LocaleOption('ps', 'Pushto Pashto'),
    _LocaleOption('pt', 'Portuguese'),
    _LocaleOption('ro', 'Romanian Moldavian Moldovan'),
    _LocaleOption('ru', 'Russian'),
    _LocaleOption('si', 'Sinhala Sinhalese'),
    _LocaleOption('sk', 'Slovak'),
    _LocaleOption('sl', 'Slovenian'),
    _LocaleOption('sq', 'Albanian'),
    _LocaleOption('sr', 'Serbian'),
    _LocaleOption('sv', 'Swedish'),
    _LocaleOption('sw', 'Swahili'),
    _LocaleOption('ta', 'Tamil'),
    _LocaleOption('te', 'Telugu'),
    _LocaleOption('th', 'Thai'),
    _LocaleOption('tl', 'Tagalog'),
    _LocaleOption('tr', 'Turkish'),
    _LocaleOption('ug', 'Uighur Uyghur'),
    _LocaleOption('uk', 'Ukrainian'),
    _LocaleOption('ur', 'Urdu'),
    _LocaleOption('uz', 'Uzbek'),
    _LocaleOption('vi', 'Vietnamese'),
    _LocaleOption('zh', 'Chinese'),
    _LocaleOption('zu', 'Zulu'),
  ];

  static final _localeOptionsMap = Map.fromEntries(
    _localeOptions.map((opt) => MapEntry(opt.code, opt)),
  );

  @override
  void initState() {
    super.initState();
    unawaited(_loadInitialData());
  }

  @override
  void didUpdateWidget(ContractManagementModal oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncControllers();
  }

  void _syncControllers() {
    if (_qtyLabelController.text != (_qtyLabel ?? '')) {
      _qtyLabelController.text = _qtyLabel ?? '';
    }
    if (_priceLabelController.text != (_priceLabel ?? '')) {
      _priceLabelController.text = _priceLabel ?? '';
    }
    if (_descriptionLabelController.text != (_descriptionLabel ?? '')) {
      _descriptionLabelController.text = _descriptionLabel ?? '';
    }
    if (_amountLabelController.text != (_amountLabel ?? '')) {
      _amountLabelController.text = _amountLabel ?? '';
    }
    if (_periodLabelController.text != (_periodLabel ?? '')) {
      _periodLabelController.text = _periodLabel ?? '';
    }
    if (_totalLabelController.text != (_totalLabel ?? '')) {
      _totalLabelController.text = _totalLabel ?? '';
    }
    if (_dueDateLabelController.text != (_dueDateLabel ?? '')) {
      _dueDateLabelController.text = _dueDateLabel ?? '';
    }
    if (_dateLabelController.text != (_dateLabel ?? '')) {
      _dateLabelController.text = _dateLabel ?? '';
    }
    if (_invoiceIdLblController.text != (_invoiceIdLbl ?? '')) {
      _invoiceIdLblController.text = _invoiceIdLbl ?? '';
    }
    if (_invoiceTitleController.text != (_invoiceTitle ?? '')) {
      _invoiceTitleController.text = _invoiceTitle ?? '';
    }
    if (_descriptionController.text != (_description ?? '')) {
      _descriptionController.text = _description ?? '';
    }
    if (_contractorRoleSublabelController.text != (_contractorRoleSublabel ?? '')) {
      _contractorRoleSublabelController.text = _contractorRoleSublabel ?? '';
    }
    if (_footnoteController.text != (_footnote ?? '')) {
      _footnoteController.text = _footnote ?? '';
    }
    if (_contractorAgreementLabelController.text != (_contractorAgreementLabel ?? '')) {
      _contractorAgreementLabelController.text = _contractorAgreementLabel ?? '';
    }
    final priceText = _defaultPrice?.toStringAsFixed(2) ?? '';
    if (_defaultPriceController.text != priceText) {
      _defaultPriceController.text = priceText;
    }
  }

  @override
  void dispose() {
    _qtyLabelController.dispose();
    _priceLabelController.dispose();
    _descriptionLabelController.dispose();
    _amountLabelController.dispose();
    _periodLabelController.dispose();
    _totalLabelController.dispose();
    _dueDateLabelController.dispose();
    _dateLabelController.dispose();
    _invoiceIdLblController.dispose();
    _invoiceTitleController.dispose();
    _descriptionController.dispose();
    _contractorRoleSublabelController.dispose();
    _footnoteController.dispose();
    _contractorAgreementLabelController.dispose();
    _defaultPriceController.dispose();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    final repo = context.read<AppRepository>();
    final contractors = await repo.contractors.getAll();
    final companies = await repo.companies.getAll();
    if (contractors.isNotEmpty) _selectedContractor = contractors.first;
    if (companies.isNotEmpty) _selectedCompany = companies.first;
  }

  void _clearForm() {
    _selectedId = null;
    _date = DateTime.now();
    _fixed = false;
    _defaultPrice = null;
    _showPeriod = true;
    _customizeLabels = false;
    _qtyLabel = null;
    _priceLabel = null;
    _descriptionLabel = null;
    _amountLabel = null;
    _periodLabel = null;
    _totalLabel = null;
    _dueDateLabel = null;
    _dateLabel = null;
    _invoiceIdLbl = null;
    _invoiceTitle = null;
    _description = null;
    _contractorRoleSublabel = null;
    _footnote = null;
    _contractorAgreementLabel = null;
    _locale = null;
    _selectedContractor = null;
    _selectedCompany = null;
    _qtyLabelController.text = '';
    _priceLabelController.text = '';
    _descriptionLabelController.text = '';
    _amountLabelController.text = '';
    _periodLabelController.text = '';
    _totalLabelController.text = '';
    _dueDateLabelController.text = '';
    _dateLabelController.text = '';
    _invoiceIdLblController.text = '';
    _invoiceTitleController.text = '';
    _descriptionController.text = '';
    _contractorRoleSublabelController.text = '';
    _footnoteController.text = '';
    _contractorAgreementLabelController.text = '';
    _defaultPriceController.text = '';
  }

  void _selectContract(Contract contract) {
    setState(() {
      _selectedId = contract.id;
      _date = contract.date;
      _fixed = contract.fixed;
      _defaultPrice = contract.defaultPrice;
      _showPeriod = contract.showPeriod;
      _customizeLabels = contract.hasCustomizations;
      _qtyLabel = contract.qtyLabel;
      _priceLabel = contract.priceLabel;
      _descriptionLabel = contract.descriptionLabel;
      _amountLabel = contract.amountLabel;
      _periodLabel = contract.periodLabel;
      _totalLabel = contract.totalLabel;
      _dueDateLabel = contract.dueDateLabel;
      _dateLabel = contract.dateLabel;
      _invoiceIdLbl = contract.invoiceIdLbl;
      _invoiceTitle = contract.invoiceTitle;
      _description = contract.description;
      _contractorRoleSublabel = contract.contractorRoleSublabel;
      _footnote = contract.footnote;
      _contractorAgreementLabel = contract.contractorAgreementLabel;
      _locale = contract.locale;
      _selectedContractor = contract.contractor;
      _selectedCompany = contract.company;
      _qtyLabelController.text = contract.qtyLabel ?? '';
      _priceLabelController.text = contract.priceLabel ?? '';
      _descriptionLabelController.text = contract.descriptionLabel ?? '';
      _amountLabelController.text = contract.amountLabel ?? '';
      _periodLabelController.text = contract.periodLabel ?? '';
      _totalLabelController.text = contract.totalLabel ?? '';
      _dueDateLabelController.text = contract.dueDateLabel ?? '';
      _dateLabelController.text = contract.dateLabel ?? '';
      _invoiceIdLblController.text = contract.invoiceIdLbl ?? '';
      _invoiceTitleController.text = contract.invoiceTitle ?? '';
      _descriptionController.text = contract.description ?? '';
      _contractorRoleSublabelController.text = contract.contractorRoleSublabel ?? '';
      _footnoteController.text = contract.footnote ?? '';
      _contractorAgreementLabelController.text = contract.contractorAgreementLabel ?? '';
      _defaultPriceController.text = contract.defaultPrice?.toStringAsFixed(2) ?? '';
    });
  }

  Future<void> _saveContract() async {
    if (_formKey.currentState!.validate() &&
        _selectedContractor != null &&
        _selectedCompany != null) {
      final contract = Contract(
        id: _selectedId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        contractor: _selectedContractor!,
        company: _selectedCompany!,
        date: _date,
        fixed: _fixed,
        defaultPrice: _fixed ? null : _defaultPrice,
        showPeriod: _showPeriod,
        qtyLabel: _customizeLabels ? _qtyLabel : null,
        priceLabel: _customizeLabels ? _priceLabel : null,
        descriptionLabel: _customizeLabels ? _descriptionLabel : null,
        amountLabel: _customizeLabels ? _amountLabel : null,
        periodLabel: _customizeLabels ? _periodLabel : null,
        totalLabel: _customizeLabels ? _totalLabel : null,
        dueDateLabel: _customizeLabels ? _dueDateLabel : null,
        dateLabel: _customizeLabels ? _dateLabel : null,
        invoiceIdLbl: _customizeLabels ? _invoiceIdLbl : null,
        invoiceTitle: _customizeLabels ? _invoiceTitle : null,
        description: _description,
        contractorRoleSublabel: _contractorRoleSublabel,
        footnote: _footnote,
        contractorAgreementLabel: _contractorAgreementLabel,
        locale: _locale,
      );
      await context.read<AppRepository>().contracts.save(contract);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Contract saved successfully')),
        );
      }
    }
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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<AppRepository>();

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: EntityListWidget<Contract>(
            title: 'Contract',
            entitiesRepo: repo.contracts,
            itemBuilder: (context, contract) {
              return EntityRowWidget<Contract>(
                entity: contract,
                isSelected: _selectedId == contract.id,
                onTap: () => _selectContract(contract),
                onDelete: () async {
                  await repo.contracts.delete(contract.id);
                  if (_selectedId == contract.id) {
                    setState(() {
                      _clearForm();
                      _selectedId = null;
                    });
                  }
                },
                titleBuilder: (c) => c.displayId,
                descriptionBuilder: (c) => c.hasCustomizations
                    ? '${c.qtyLabel ?? 'Qty'} | ${c.priceLabel ?? 'Price'} | ${c.fixed ? 'Fixed' : 'Variable'}'
                    : '${c.fixed ? 'Fixed' : 'Variable'}',
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
          child: _selectedId != null ? buildForm() : const Center(child: Text('Select contract')),
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Contract Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SelectField<Contractor>(
                    label: 'Contractor',
                    value: _selectedContractor,
                    itemsRepository: context.read<AppRepository>().contractors,
                    displayBuilder: (c) => c.fullName,
                    onChanged: (value) {
                      _selectedContractor = value;
                    },
                  ),
                  const SizedBox(height: 12),
                  SelectField<Company>(
                    label: 'Company',
                    value: _selectedCompany,
                    itemsRepository: context.read<AppRepository>().companies,
                    displayBuilder: (c) => c.name,
                    onChanged: (value) {
                      _selectedCompany = value;
                    },
                  ),
                  const SizedBox(height: 12),
                  DateField(
                    label: 'Contract Date',
                    value: _date,
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 12),
                  TextMultilineField(
                    label: 'Description (e.g. a role that contractor does under contract)',
                    controller: _descriptionController,
                    maxLines: 5,
                    onChanged: (value) {
                      _description = value.isEmpty ? null : value;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Columns',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text('Fixed Price Mode'),
                    subtitle: const Text(
                      'When fixed, invoice shows Amount instead of Qty × Price',
                    ),
                    value: _fixed,
                    onChanged: (value) {
                      setState(() {
                        _fixed = value;
                      });
                    },
                  ),
                  if (!_fixed) ...[
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Default Price',
                      controller: _defaultPriceController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _defaultPrice = double.tryParse(value);
                      },
                    ),
                  ],
                  const SizedBox(height: 12),
                  SwitchListTile(
                    title: const Text('Show Period'),
                    subtitle: const Text('Display period column in invoice items'),
                    value: _showPeriod,
                    onChanged: (value) {
                      _showPeriod = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Customization',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text('Customize Labels'),
                    subtitle: const Text('Enable to customize label text in invoices'),
                    value: _customizeLabels,
                    onChanged: (value) {
                      setState(() {
                        _customizeLabels = value;
                      });
                    },
                  ),
                  if (_customizeLabels) ...[
                    SelectField<_LocaleOption>(
                      label: 'Locale for Dates formatting (Default: English)',
                      value: _locale != null ? _localeOptionsMap[_locale] : null,
                      items: _localeOptions,
                      displayBuilder: (opt) => opt.name,
                      onChanged: (value) {
                        _locale = value?.code;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0, top: 16),
                      child: Text(
                        'Table',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    StringTextField(
                      label: 'Quantity Column Label (Default: Qty)',
                      controller: _qtyLabelController,
                      onChanged: (value) {
                        _qtyLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Price Column Label (Default: Price)',
                      controller: _priceLabelController,
                      onChanged: (value) {
                        _priceLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Description Column Label (Default: Description)',
                      controller: _descriptionLabelController,
                      onChanged: (value) {
                        _descriptionLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Amount Column Label (Default: Amount)',
                      controller: _amountLabelController,
                      onChanged: (value) {
                        _amountLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Period Column Label (Default: Period)',
                      controller: _periodLabelController,
                      onChanged: (value) {
                        _periodLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Total line Label (Default: Total)',
                      controller: _totalLabelController,
                      onChanged: (value) {
                        _totalLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0, top: 16),
                      child: Text(
                        'Invoice meta',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    StringTextField(
                      label: 'Invoice Title Label (Default: INVOICE)',
                      controller: _invoiceTitleController,
                      onChanged: (value) {
                        _invoiceTitle = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Invoice ID Label (Default: ID)',
                      controller: _invoiceIdLblController,
                      onChanged: (value) {
                        _invoiceIdLbl = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Date Label (Default: Date)',
                      controller: _dateLabelController,
                      onChanged: (value) {
                        _dateLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Due Date Label (Default: Due)',
                      controller: _dueDateLabelController,
                      onChanged: (value) {
                        _dueDateLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0, top: 16),
                      child: Text(
                        'Contractor meta',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    StringTextField(
                      label: 'Contractor Role Sublabel (Default: Contractor)',
                      controller: _contractorRoleSublabelController,
                      onChanged: (value) {
                        _contractorRoleSublabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 12),
                    StringTextField(
                      label: 'Contractor Agreement Label (Default: Contractor Agreement dated)',
                      controller: _contractorAgreementLabelController,
                      onChanged: (value) {
                        _contractorAgreementLabel = value.isEmpty ? null : value;
                      },
                    ),
                    const SizedBox(height: 24),
                    StringTextField(
                      label: 'Footnote (Default: _Thank you for your business_)',
                      controller: _footnoteController,
                      maxLines: 5,
                      onChanged: (value) {
                        _footnote = value.isEmpty ? null : value;
                      },
                    ),
                  ],
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
                  onPressed: _saveContract,
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

class _LocaleOption {
  final String code;
  final String name;

  const _LocaleOption(this.code, this.name);
}
