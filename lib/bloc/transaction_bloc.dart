import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:xpensy/models/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends HydratedBloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionLoading()) {
    on<TransactionLoad>(_loadTransaction);
    on<TransactionAdd>(_addTransaction);
    on<TransactionDelete>(_deleteTransaction);
    on<TransactionEdit>(_editTransaction);
  }

  /// Event Handler for [TransactionLoad] event
  void _loadTransaction(TransactionLoad event, Emitter<TransactionState> emit) {
    emit(TransactionLoaded(transactionList: event.transactionList));
  }

  /// Event Handler for [TransactionAdd] event
  void _addTransaction(TransactionAdd event, Emitter<TransactionState> emit) {
    final state = this.state;
    if (state is TransactionLoaded) {
      emit(TransactionLoaded(
          transactionList: List.from(state.transactionList)
            ..add(event.transaction)));
    }
  }

  /// Event Handler for [TransactionDelete] event
  void _deleteTransaction(
      TransactionDelete event, Emitter<TransactionState> emit) {
    final state = this.state;
    if (state is TransactionLoaded) {
      List<TransactionModel> txList = state.transactionList.where(
        (element) {
          return element.id != event.transactionId;
        },
      ).toList();
      emit(TransactionLoaded(transactionList: txList));
    }
  }

  /// Event Handler for [TransactionEdit] event
  void _editTransaction(TransactionEdit event, Emitter<TransactionState> emit) {
    final state = this.state;
    if (state is TransactionLoaded) {
      final txList = [...state.transactionList];
      final index = txList.indexWhere((element) => element.id == event.id);
      txList[index] = event.transaction;
      emit(TransactionLoaded(transactionList: txList));
    }
  }




  //Filtering transactions of last 7 days
  // List<TransactionItem> get recentTransaction {
  //   return _transactions.where((element) {
  //     return DateTime.parse(element.dateTime)
  //         .isAfter(DateTime.now().subtract(const Duration(days: 7)));
  //   }).toList();
  // }


  // Hydrated Cubit - JSON Deserialization
  @override
  TransactionState? fromJson(Map<String, dynamic> json) {
    final txList = json['transactionList'];
    List<TransactionModel> txListDecoded = [];
    for (var item in txList) {
      txListDecoded.add(TransactionModel.fromJson(item));
    }
    return TransactionLoaded(transactionList: txListDecoded);
  }

  // Hydrated Cubit - JSON Serialization
  @override
  Map<String, dynamic>? toJson(TransactionState state) {
    if (state is TransactionLoaded) {
      final txList = state.transactionList;
      List txListEncoded = [];
      for (var item in txList) {
        txListEncoded.add(item.toJson());
      }
      return {
        'transactionList': txListEncoded,
      };
    }
    return null;
  }


  // For tracking the state change
  @override
  void onChange(Change<TransactionState> change) {
    print(change.toString());
    super.onChange(change);
  }
}
