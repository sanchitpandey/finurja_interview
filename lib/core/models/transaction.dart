import 'package:intl/intl.dart';

class Transaction {
  final String id;
  final String accountId;
  final TransactionType type;
  final double amount;
  final DateTime date;
  final String description;

  Transaction({
    required this.id,
    required this.accountId,
    required this.type,
    required this.amount,
    required this.date,
    required this.description,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      accountId: json['accountId'],
      type: json['type'] == 'credit'
          ? TransactionType.credit
          : TransactionType.debit,
      amount: double.parse(json['amount'].toString()),
      date: DateFormat('yyyy-MM-dd').parse(json['date']),
      description: json['description'],
    );
  }
}

enum TransactionType { credit, debit }
