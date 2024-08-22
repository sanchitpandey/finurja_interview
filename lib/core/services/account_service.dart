import 'package:finurja_interview/core/models/account.dart';
import 'package:finurja_interview/core/models/transaction.dart';
import 'package:finurja_interview/core/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class AccountService extends ChangeNotifier {
  List<Account> _accounts = [];
  final TransactionService _transactionService;

  AccountService(this._transactionService);

  List<Account> get accounts => _accounts;

  Future<void> fetchAccounts() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/accounts.json');
    final List<dynamic> jsonData = json.decode(jsonString);

    _accounts = jsonData.map((json) => Account.fromJson(json)).toList();
    notifyListeners();
  }

  double getAccountBalance(String accountId) {
    List<Transaction> transactions =
        _transactionService.getTransactionsForAccount(accountId);

    return transactions.fold(0.0, (sum, transaction) {
      return transaction.type == TransactionType.credit
          ? sum + transaction.amount
          : sum - transaction.amount;
    });
  }

  double get totalBalance {
    return _accounts.fold(0.0, (prev, account) {
      return prev + getAccountBalance(account.id);
    });
  }
}
