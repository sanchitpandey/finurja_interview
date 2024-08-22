import 'package:finurja_interview/pages/transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/services/account_service.dart';
import '../widgets/account_card.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<AccountService>(context, listen: false).fetchAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Accounts'),
      ),
      body: Consumer<AccountService>(
        builder: (context, accountService, child) {
          final accounts = accountService.accounts;
          final totalBalance = accountService.totalBalance;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Balance: \₹${totalBalance.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TransactionPage(account: account),
                          ),
                        );
                      },
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: AccountCard(account: account)),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
