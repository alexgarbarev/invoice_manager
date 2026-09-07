import 'dart:typed_data';

import '../repositories/in_memory_repository.dart';

class Contractor implements Identifiable {
  @override
  final String id;
  final String abbr;
  final String fullName;
  final String? paymentInfo;
  final String? contractorInfo;
  final Uint8List? signature;
  final DateTime createdAt;
  final DateTime updatedAt;

  Contractor({
    required this.id,
    required this.abbr,
    required this.fullName,
    this.paymentInfo,
    this.contractorInfo,
    this.signature,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  Contractor copyWith({
    String? id,
    String? abbr,
    String? fullName,
    String? paymentInfo,
    String? contractorInfo,
    Uint8List? signature,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Contractor(
      id: id ?? this.id,
      abbr: abbr ?? this.abbr,
      fullName: fullName ?? this.fullName,
      paymentInfo: paymentInfo ?? this.paymentInfo,
      contractorInfo: contractorInfo ?? this.contractorInfo,
      signature: signature ?? this.signature,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contractor &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          abbr == other.abbr &&
          fullName == other.fullName &&
          paymentInfo == other.paymentInfo &&
          contractorInfo == other.contractorInfo &&
          signature?.length == other.signature?.length;

  @override
  int get hashCode =>
      Object.hash(id, abbr, fullName, paymentInfo, contractorInfo, signature?.length);

  @override
  String toString() {
    return 'Contractor{id: $id, abbr: $abbr, fullName: $fullName, paymentInfo: $paymentInfo, contractorInfo: $contractorInfo, signature: $signature}';
  }
}
