import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xpensy/models/transaction.dart';
import 'package:xpensy/widgets/bar_chart.dart';

// ignore: must_be_immutable
class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;
  Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get _groupedTxValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].dateTime.day == weekDay.day &&
            recentTransactions[i].dateTime.month == weekDay.month &&
            recentTransactions[i].dateTime.year == weekDay.year) {
          totalSum = totalSum + recentTransactions[i].transactionAmount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get _totalSpending {
    //alternative way
    // double totalSpending = 0;
    // for (var i = 0; i < groupedTxValues.length; i++) {
    //   totalSpending =
    //       totalSpending + double.parse(groupedTxValues[i]['amount'].toString());
    // }
    // return totalSpending;
    return _groupedTxValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  double _getHeight(double txCurrentDay) {
    return txCurrentDay / _totalSpending;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            padding: const EdgeInsets.all(8.0),
            child: _totalSpending != 0.0
                ? BarChart(
                    groupedTxValues: _groupedTxValues, getHeight: _getHeight)
                : const Center(
                    child: Text('Add transactions to make graph visible'))));
  }
}
