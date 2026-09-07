import '../common/sequence_generator.dart';

class InvoiceItem {
  final String id;
  final String description;
  final int quantity;
  final double price;
  final String? period;
  final double? amount;

  static final idGenerator = SequenceGenerator.timestamp(prefix: 'II-');

  InvoiceItem({
    required this.id,
    required this.description,
    required this.quantity,
    required this.price,
    this.period,
    this.amount,
  });

  double get totalAmount => amount ?? (quantity * price);

  InvoiceItem copyWith({
    String? id,
    String? description,
    int? quantity,
    double? price,
    String? period,
    double? amount,
  }) {
    return InvoiceItem(
      id: id ?? this.id,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      period: period ?? this.period,
      amount: amount ?? this.amount,
    );
  }

  @override
  String toString() {
    return 'InvoiceItem{id: $id, description: $description, quantity: $quantity, price: $price, period: $period, amount: $amount}';
  }

  static String generateId() {
    return idGenerator.next();
  }
}
