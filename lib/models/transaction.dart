class Transaction {
  String id;
  String transactionName;
  double transactionAmount;
  DateTime dateTime;
  Transaction(
      {required this.id,
      required this.transactionName,
      required this.transactionAmount,
      required this.dateTime});
}
