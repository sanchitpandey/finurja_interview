import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../core/models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        leading: Icon(
          transaction.type == TransactionType.credit
              ? Icons.arrow_downward
              : Icons.arrow_upward,
          color: transaction.type == TransactionType.credit
              ? Colors.green
              : Colors.red,
        ),
        tileColor: transaction.type == TransactionType.credit
            ? Colors.green.withOpacity(.4)
            : Colors.red.withOpacity(.4),
        title: Text(
          transaction.description,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(DateFormat('dd-MM-yyyy').format(transaction.date)),
        trailing: Text(
          '\₹${transaction.amount.toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
