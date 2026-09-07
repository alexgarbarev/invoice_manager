import '../repositories/in_memory_repository.dart';

class Company implements Identifiable {
  @override
  final String id;
  final String name;
  final String abbr;
  final int paymentWeeks;
  final String? currencyPrefix;
  final String? companyInfo;
  final DateTime updatedAt;

  Company({
    required this.id,
    required this.name,
    required this.abbr,
    required this.updatedAt,
    this.paymentWeeks = 3,
    this.currencyPrefix,
    this.companyInfo,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Company &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          abbr == other.abbr &&
          paymentWeeks == other.paymentWeeks &&
          currencyPrefix == other.currencyPrefix &&
          companyInfo == other.companyInfo &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      Object.hash(id, name, abbr, paymentWeeks, currencyPrefix, companyInfo, updatedAt);

  @override
  String toString() {
    return 'Company{id: $id, name: $name, abbr: $abbr, paymentWeeks: $paymentWeeks, currencyPrefix: $currencyPrefix, companyInfo: $companyInfo}';
  }
}
