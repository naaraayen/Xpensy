import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpensy/widgets/transaction_item.dart';

import '../widgets/bar_chart.dart';
import '../widgets/neumorphic_container.dart';

// ignore: must_be_immutable
class Chart extends StatelessWidget {
  List<TransactionItem> recentTransactions;
  Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get _groupedTxValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (DateTime.parse( recentTransactions[i].dateTime).day == weekDay.day &&
            DateTime.parse( recentTransactions[i].dateTime).month == weekDay.month &&
            DateTime.parse( recentTransactions[i].dateTime).year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].transactionAmount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get _totalSpending {
    return _groupedTxValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  double _getHeight(double txCurrentDay) {
    return txCurrentDay / _totalSpending;
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
        offset: 2,
        blurRadius: 4,
        color: Colors.grey.shade200,
        padding: const EdgeInsets.all(10),
        child: _totalSpending != 0.0
            ? BarChart(groupedTxValues: _groupedTxValues, getHeight: _getHeight)
            : const Center(
                child: Text('Add transactions to make graph visible')));
  }
}
