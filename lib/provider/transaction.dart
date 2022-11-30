import 'package:flutter/material.dart';


class TransactionItem {
  String id;
  String transactionName;
  double transactionAmount;
  DateTime dateTime;
  TransactionItem(
      {required this.id,
      required this.transactionName,
      required this.transactionAmount,
      required this.dateTime});
}

class Transaction with ChangeNotifier {

  // TODO: Implement shared preference
  final List<TransactionItem> _tx = [];

  List<TransactionItem> get tx {
    return _tx;
  }

  List<TransactionItem> get recentTransaction {
    return _tx.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void txInfo(String getTitle, double getAmount, DateTime getPickedDate) {
    _tx.add(TransactionItem(
        id: DateTime.now().toString(),
        transactionName: getTitle,
        transactionAmount: getAmount,
        dateTime: getPickedDate));
        notifyListeners();
  }

  void removeTx(int index) {
    _tx.removeAt(index);
    notifyListeners();
  }
}
