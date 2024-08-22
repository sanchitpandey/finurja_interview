import 'package:finurja_interview/core/models/transaction.dart';
import 'package:finurja_interview/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final ScrollController scrollController;
  final VoidCallback? onLoadMore;
  final bool hasMoreTransactions;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.scrollController,
    this.onLoadMore,
    required this.hasMoreTransactions,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalTransactionHeight = transactions.length * 80.0;
        final isScrollable = totalTransactionHeight > constraints.maxHeight;

        return ListView.builder(
          controller: scrollController,
          itemCount: transactions.length +
              (hasMoreTransactions && isScrollable ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < transactions.length) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TransactionCard(transaction: transactions[index]),
              );
            } else if (hasMoreTransactions &&
                isScrollable &&
                onLoadMore != null) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}
