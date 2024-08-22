import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/models/account.dart';
import '../core/models/transaction.dart';
import '../core/services/transaction_service.dart';
import '../widgets/filter_bar.dart';
import '../widgets/transaction_list.dart';

class TransactionPage extends StatefulWidget {
  final Account account;

  const TransactionPage({super.key, required this.account});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late ScrollController _scrollController;
  TransactionType? _selectedType;
  DateTime? _startDate;
  DateTime? _endDate;
  int _limit = 10;
  bool _hasMoreTransactions = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    Provider.of<TransactionService>(context, listen: false).fetchTransactions();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _loadMoreTransactions();
    }
  }

  void _loadMoreTransactions() {
    setState(() {
      _limit += 10;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final transactions =
          Provider.of<TransactionService>(context, listen: false)
              .getTransactionsForAccount(
        widget.account.id,
        type: _selectedType,
        startDate: _startDate,
        endDate: _endDate,
        limit: _limit + 1,
      );
      setState(() {
        _hasMoreTransactions = transactions.length > _limit;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions - ${widget.account.name}'),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: Consumer<TransactionService>(
              builder: (context, transactionService, child) {
                final transactions =
                    transactionService.getTransactionsForAccount(
                  widget.account.id,
                  type: _selectedType,
                  startDate: _startDate,
                  endDate: _endDate,
                  limit: _limit,
                );
                return TransactionList(
                  transactions: transactions,
                  scrollController: _scrollController,
                  onLoadMore: _loadMoreTransactions,
                  hasMoreTransactions: _hasMoreTransactions,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return FilterBar(
      selectedType: _selectedType,
      startDate: _startDate,
      endDate: _endDate,
      onTypeChanged: (value) {
        setState(() {
          _selectedType = value;
          _limit = 10;
          _hasMoreTransactions = true;
        });
      },
      onDateRangeChanged: (dateRange) {
        if (dateRange != null) {
          setState(() {
            _startDate = dateRange.start;
            _endDate = dateRange.end;
            _limit = 10;
            _hasMoreTransactions = true;
          });
        }
      },
      onDurationChanged: (duration) {
        final now = DateTime.now();
        setState(() {
          switch (duration) {
            case '1month':
              _startDate = now.subtract(const Duration(days: 30));
              break;
            case '3months':
              _startDate = now.subtract(const Duration(days: 90));
              break;
            case '6months':
              _startDate = now.subtract(const Duration(days: 180));
              break;
          }
          _endDate = now;
          _limit = 10;
          _hasMoreTransactions = true;
        });
      },
    );
  }
}
