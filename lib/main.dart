import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/services/account_service.dart';
import 'core/services/transaction_service.dart';
import 'core/utils/theme.dart';
import 'pages/account_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TransactionService()..fetchTransactions()),
        ChangeNotifierProxyProvider<TransactionService, AccountService>(
          create: (_) =>
              AccountService(Provider.of<TransactionService>(_, listen: false)),
          update: (_, transactionService, accountService) =>
              accountService!..fetchAccounts(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finurja Interview',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      home: const AccountPage(),
    );
  }
}
