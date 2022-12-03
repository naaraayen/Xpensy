import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionItem {
  late String id;
  late String transactionName;
  late double transactionAmount;
  late String dateTime;
  TransactionItem(
      {required this.id,
      required this.transactionName,
      required this.transactionAmount,
      required this.dateTime});

  //JSON serialization
  //Map to Object
  TransactionItem.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    transactionName = map['transactionName'];
    transactionAmount = map['transactionAmount'];
    dateTime = map['dateTime'];
  }

  //Object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionName': transactionName,
      'transactionAmount': transactionAmount,
      'dateTime': dateTime,
    };
  }
}

class Transaction with ChangeNotifier {
  var _isDataAvailable = false;
  final List<Map<String, dynamic>> _transactionsInMap = [];
  final List<TransactionItem> _transactions = [];

  bool get isDataAvailable {
    return _isDataAvailable;
  }

  List<TransactionItem> get tx {
    return _transactions;
  }

  //Converting list of map to list of object
  void txJsonToObject(Map<String, dynamic> getMap) {
      _transactions.add(TransactionItem.fromMap(getMap));
    }

  //Alternative Way
  //   void txJsonToObject() {
  //   final List<TransactionItem> txData = [];
  //   for (var i in _transactionsInMap) {
  //     txData.add(TransactionItem.fromMap(i));
  //   }
  //   _transactions = txData;
  // }

  //Filtering transactions of last 7 days
  List<TransactionItem> get recentTransaction {
    return _transactions.where((element) {
      return DateTime.parse(element.dateTime)
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  //Implementing Shared Prefs
  void setPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'txList': _transactionsInMap,
    });
    prefs.setString('userData', userData);
  }

  //Adding transactions
  void txInfo(String getTitle, double getAmount, DateTime getPickedDate) {
    _transactionsInMap.add(TransactionItem(
            id: DateTime.now().toString(),
            transactionName: getTitle,
            transactionAmount: getAmount,
            dateTime: getPickedDate.toString())
        .toMap());
    txJsonToObject(_transactionsInMap.last);
    notifyListeners();
    setPreferences();
  }

  //Retrieving shared transactions whenever the app loads up
  Future<void> retrieveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return;
    }
    final getUserData = prefs.getString('userData');
    if (getUserData == null) {
      return;
    }
    final extractedData = json.decode(getUserData) as Map<String, dynamic>;
    final txDataObject = extractedData['txList'];
    for (var element in txDataObject) {
      _transactionsInMap.add(element);
      txJsonToObject(element);
    }
    
    _isDataAvailable = true;
    notifyListeners();
  }

  //Removing transactions
  void removeTx(int index) {
    _transactions.removeAt(index);
    _transactionsInMap.removeAt(index);

    notifyListeners();
    setPreferences();
  }
}
