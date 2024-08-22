import 'package:flutter/material.dart';
import '../core/models/transaction.dart';

class FilterBar extends StatelessWidget {
  final TransactionType? selectedType;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(TransactionType?) onTypeChanged;
  final Function(DateTimeRange?) onDateRangeChanged;
  final Function(String) onDurationChanged;

  const FilterBar({
    super.key,
    required this.selectedType,
    required this.startDate,
    required this.endDate,
    required this.onTypeChanged,
    required this.onDateRangeChanged,
    required this.onDurationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButton<TransactionType>(
                  isExpanded: true,
                  value: selectedType,
                  items: [null, ...TransactionType.values].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Center(
                          child:
                              Text(type?.toString().split('.').last ?? 'All')),
                    );
                  }).toList(),
                  onChanged: onTypeChanged,
                  hint: const Text('Transaction Type'),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => onDurationChanged('1month'),
                child: const Text('1 Month'),
              ),
              ElevatedButton(
                onPressed: () => onDurationChanged('3months'),
                child: const Text('3 Months'),
              ),
              ElevatedButton(
                onPressed: () => onDurationChanged('6months'),
                child: const Text('6 Months'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
