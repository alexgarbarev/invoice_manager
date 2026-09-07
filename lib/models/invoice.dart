import '../common/sequence_generator.dart';
import '../repositories/in_memory_repository.dart';
import 'contract.dart';
import 'invoice_item.dart';

enum InvoiceStatus { draft, sent, paid, cancelled }

class Invoice implements Identifiable {
  static final _idGenerator = SequenceGenerator.timestamp(prefix: 'INV-');

  @override
  final String id;
  final Contract contract;
  final DateTime date;
  final DateTime dueDate;
  final List<InvoiceItem> items;
  final InvoiceStatus status;

  bool hasOutdatedCompany = false;
  bool hasOutdatedContractor = false;
  bool hasOutdatedContract = false;

  bool get hasOutdatedRefs => hasOutdatedCompany || hasOutdatedContract || hasOutdatedContractor;

  String get outdatedText {
    final items = [
      if (hasOutdatedCompany) 'company',
      if (hasOutdatedContractor) 'contractor',
      if (hasOutdatedContract) 'contract',
    ];
    if (items.isEmpty) return '';
    final joint = (items.length == 1) ? 'is' : 'are';
    return '${items.join(', ')} $joint outdated';
  }

  Invoice({
    required this.id,
    required this.contract,
    required this.date,
    required this.dueDate,
    required this.items,
    required this.status,
  });

  double get totalAmount => items.fold(0, (sum, item) => sum + item.totalAmount);

  factory Invoice.create({
    String? id,
    required Contract contract,
    required DateTime date,
    DateTime? dueDate,
    required List<InvoiceItem> items,
    required InvoiceStatus status,
  }) {
    final internalId = generateId();
    return Invoice(
      id: id ?? internalId,
      contract: contract,
      date: date,
      dueDate: dueDate ?? date.add(const Duration(days: 21)),
      items: items,
      status: status,
    );
  }

  Invoice copyWith({
    String? id,
    Contract? contract,
    DateTime? date,
    DateTime? dueDate,
    List<InvoiceItem>? items,
    InvoiceStatus? status,
  }) {
    return Invoice(
      id: id ?? this.id,
      contract: contract ?? this.contract,
      date: date ?? this.date,
      dueDate: dueDate ?? this.dueDate,
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  Invoice duplicate() {
    final newId = generateId();
    return copyWith(
      id: newId,
      items: items.map((i) => i.copyWith(id: InvoiceItem.generateId())).toList(),
      status: .draft,
    );
  }

  @override
  String toString() {
    return 'Invoice{id: $id, displayId: $displayId, date: $date, dueDate: $dueDate, status: $status}';
  }

  static String generateId() {
    return _idGenerator.next();
  }

  static String generateDisplayId(Contract contract, DateTime date) {
    final contractor = contract.contractor;
    final company = contract.company;
    final dateStr =
        '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
    return '${contractor.abbr}-${company.abbr}-$dateStr';
  }

  String get displayId {
    return generateDisplayId(contract, date);
  }
}
