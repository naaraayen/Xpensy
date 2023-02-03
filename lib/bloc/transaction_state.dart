part of 'transaction_bloc.dart';

// Possible states for Transaction Bloc
@immutable
abstract class TransactionState extends Equatable {
}

class TransactionLoading extends TransactionState {
  @override
  List<Object?> get props => [];
}

class TransactionLoaded extends TransactionState {
  final List<TransactionModel> transactionList;
   TransactionLoaded({
    required this.transactionList,
  });

  @override
  List<Object?> get props => [transactionList];
}
