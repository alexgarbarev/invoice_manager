import 'package:intl/intl.dart';

import '../repositories/in_memory_repository.dart';
import 'models.dart';

class Contract implements Identifiable {
  @override
  final String id;
  final Contractor contractor;
  final Company company;
  final DateTime date;
  final bool fixed;
  final double? defaultPrice;
  final bool showPeriod;
  final String? qtyLabel;
  final String? priceLabel;
  final String? descriptionLabel;
  final String? amountLabel;
  final String? periodLabel;
  final String? totalLabel;
  final String? dueDateLabel;
  final String? dateLabel;
  final String? invoiceIdLbl;
  final String? invoiceTitle;
  final String? description;
  final String? contractorRoleSublabel;
  final String? footnote;
  final String? contractorAgreementLabel;
  final String? locale;

  Contract({
    required this.id,
    required this.contractor,
    required this.company,
    required this.date,
    required this.fixed,
    this.defaultPrice,
    required this.showPeriod,
    this.qtyLabel,
    this.priceLabel,
    this.descriptionLabel,
    this.amountLabel,
    this.periodLabel,
    this.totalLabel,
    this.dueDateLabel,
    this.dateLabel,
    this.invoiceIdLbl,
    this.invoiceTitle,
    this.description,
    this.contractorRoleSublabel,
    this.footnote,
    this.contractorAgreementLabel,
    this.locale,
  });

  String get displayId {
    final df = DateFormat('dd MMM yyyy');
    return '${contractor.abbr}-${company.abbr} at ${df.format(date)}';
  }

  String get qtyLabelOrDefault => qtyLabel ?? 'Qty';

  String get priceLabelOrDefault => priceLabel ?? 'Price';

  String get descriptionLabelOrDefault => descriptionLabel ?? 'Description';

  String get amountLabelOrDefault => amountLabel ?? 'Amount';

  String get periodLabelOrDefault => periodLabel ?? 'Period';

  String get totalLabelOrDefault => totalLabel ?? 'Total';

  String get dueDateLabelOrDefault => dueDateLabel ?? 'Due';

  String get dateLabelOrDefault => dateLabel ?? 'Date';

  String get invoiceIdLabelOrDefault => invoiceIdLbl ?? 'ID';

  String get invoiceTitleOrDefault => invoiceTitle ?? 'INVOICE';

  String get footnoteOrDefault => footnote ?? '_Thank you for your business!_';

  String get contractorRoleSublabelOrDefault => contractorRoleSublabel ?? 'Contractor';

  String get contractorAgreementLabelOrDefault =>
      contractorAgreementLabel ?? 'Contractor Agreement dated';
 
  bool get hasCustomizations =>
      qtyLabel != null ||
      priceLabel != null ||
      descriptionLabel != null ||
      amountLabel != null ||
      periodLabel != null ||
      totalLabel != null ||
      dueDateLabel != null ||
      dateLabel != null ||
      invoiceIdLbl != null ||
      invoiceTitle != null ||
      contractorRoleSublabel != null ||
      footnote != null ||
      contractorAgreementLabel != null ||
      locale != null;

  Contract copyWith({
    String? id,
    Contractor? contractor,
    Company? company,
    DateTime? date,
    bool? fixed,
    double? defaultPrice,
    bool? showPeriod,
    String? qtyLabel,
    String? priceLabel,
    String? descriptionLabel,
    String? amountLabel,
    String? periodLabel,
    String? totalLabel,
    String? dueDateLabel,
    String? dateLabel,
    String? invoiceIdLbl,
    String? invoiceTitle,
    String? description,
    String? contractorRoleSublabel,
    String? footnote,
    String? contractorAgreementLabel,
    String? locale,
  }) {
    return Contract(
      id: id ?? this.id,
      contractor: contractor ?? this.contractor,
      company: company ?? this.company,
      date: date ?? this.date,
      fixed: fixed ?? this.fixed,
      defaultPrice: defaultPrice ?? this.defaultPrice,
      showPeriod: showPeriod ?? this.showPeriod,
      qtyLabel: qtyLabel ?? this.qtyLabel,
      priceLabel: priceLabel ?? this.priceLabel,
      descriptionLabel: descriptionLabel ?? this.descriptionLabel,
      amountLabel: amountLabel ?? this.amountLabel,
      periodLabel: periodLabel ?? this.periodLabel,
      totalLabel: totalLabel ?? this.totalLabel,
      dueDateLabel: dueDateLabel ?? this.dueDateLabel,
      dateLabel: dateLabel ?? this.dateLabel,
      invoiceIdLbl: invoiceIdLbl ?? this.invoiceIdLbl,
      invoiceTitle: invoiceTitle ?? this.invoiceTitle,
      description: description ?? this.description,
      contractorRoleSublabel: contractorRoleSublabel ?? this.contractorRoleSublabel,
      footnote: footnote ?? this.footnote,
      contractorAgreementLabel: contractorAgreementLabel ?? this.contractorAgreementLabel,
      locale: locale ?? this.locale,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contract &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          fixed == other.fixed &&
          defaultPrice == other.defaultPrice &&
          showPeriod == other.showPeriod &&
          qtyLabel == other.qtyLabel &&
          priceLabel == other.priceLabel &&
          descriptionLabel == other.descriptionLabel &&
          amountLabel == other.amountLabel &&
          periodLabel == other.periodLabel &&
          totalLabel == other.totalLabel &&
          dueDateLabel == other.dueDateLabel &&
          dateLabel == other.dateLabel &&
          invoiceIdLbl == other.invoiceIdLbl &&
          invoiceTitle == other.invoiceTitle &&
          description == other.description &&
          contractorRoleSublabel == other.contractorRoleSublabel &&
          footnote == other.footnote &&
          contractorAgreementLabel == other.contractorAgreementLabel &&
          locale == other.locale;

  @override
  int get hashCode => Object.hash(
    id,
    date,
    fixed,
    defaultPrice,
    showPeriod,
    qtyLabel,
    priceLabel,
    descriptionLabel,
    amountLabel,
    periodLabel,
    totalLabel,
    dueDateLabel,
    dateLabel,
    invoiceIdLbl,
    invoiceTitle,
    description,
    contractorRoleSublabel,
    footnote,
    contractorAgreementLabel,
    locale,
  );

  @override
  String toString() {
    return 'Contract{id: $id, displayId: $displayId, date: $date, fixed: $fixed}';
  }
}
