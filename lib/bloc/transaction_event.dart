part of 'transaction_bloc.dart';


// Possible Events for Transaction Bloc
@immutable
abstract class TransactionEvent extends Equatable {}

class TransactionLoad extends TransactionEvent {
  final List<TransactionModel> transactionList;

  TransactionLoad({this.transactionList = const <TransactionModel>[]});

  @override
  List<Object?> get props => [transactionList];
}

class TransactionAdd extends TransactionEvent {
  final TransactionModel transaction;
  TransactionAdd({required this.transaction});

  @override
  List<Object?> get props => [transaction];
}

class TransactionEdit extends TransactionEvent {
  final String id;
  final TransactionModel transaction;
  TransactionEdit({
    required this.id,
    required this.transaction,
  });

  @override
  List<Object?> get props => [transaction];
}

class TransactionDelete extends TransactionEvent {
  final String transactionId;
  TransactionDelete({required this.transactionId});

  @override
  List<Object?> get props => [transactionId];
}

class TransactionRecent extends TransactionEvent {
  final List<TransactionModel> transactionList;
  TransactionRecent({required this.transactionList});

  @override
  List<Object?> get props => [transactionList];
}
