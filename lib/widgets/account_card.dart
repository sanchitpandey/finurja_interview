import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/models/account.dart';
import '../core/services/account_service.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    final accountService = Provider.of<AccountService>(context);
    final balance = accountService.getAccountBalance(account.id);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              account.bankIcon,
              width: 48,
              height: 48,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Account Number: ${account.accountNumber}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\₹${balance.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
