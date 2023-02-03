import 'dart:convert';

class TransactionModel {
  late String id;
  late String transactionName;
  late double transactionAmount;
  late String dateTime;
  TransactionModel(
      {required this.id,
      required this.transactionName,
      required this.transactionAmount,
      required this.dateTime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'transactionName': transactionName,
      'transactionAmount': transactionAmount,
      'dateTime': dateTime,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      transactionName: map['transactionName'],
      transactionAmount: map['transactionAmount'],
      dateTime: map['dateTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));
}
