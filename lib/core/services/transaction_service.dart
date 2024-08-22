import 'dart:convert';

import 'package:finurja_interview/core/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionService extends ChangeNotifier {
  List<Transaction> _transactions = [];
  Map<String, List<Transaction>> _transactionsByAccountId = {};

  List<Transaction> get transactions => _transactions;

  Future<void> fetchTransactions() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/transactions.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    _transactions = jsonData.map((json) => Transaction.fromJson(json)).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    _groupTransactionsByAccountId();
    notifyListeners();
  }

  List<Transaction> getTransactionsForAccount(
    String accountId, {
    TransactionType? type,
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
  }) {
    List<Transaction> filteredTransactions =
        _transactionsByAccountId[accountId] ?? [];

    if (type != null) {
      filteredTransactions =
          filteredTransactions.where((tx) => tx.type == type).toList();
    }

    if (startDate != null && endDate != null) {
      filteredTransactions = filteredTransactions
          .where((tx) =>
              tx.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
              tx.date.isBefore(endDate.add(const Duration(days: 1))))
          .toList();
    }

    if (limit != null) {
      filteredTransactions = filteredTransactions.take(limit).toList();
    }

    return filteredTransactions;
  }

  void _groupTransactionsByAccountId() {
    _transactionsByAccountId = {};
    for (final transaction in _transactions) {
      if (!_transactionsByAccountId.containsKey(transaction.accountId)) {
        _transactionsByAccountId[transaction.accountId] = [];
      }
      _transactionsByAccountId[transaction.accountId]!.add(transaction);
    }
  }
}
