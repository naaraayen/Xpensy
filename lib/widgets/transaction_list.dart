import 'package:flutter/material.dart';
import './transaction_item.dart';
import 'package:xpensy/models/transaction.dart';

// ignore: must_be_immutable
class TransactionList extends StatelessWidget {
  final List<Transaction> tx;
  final Function removeTx;
  const TransactionList(this.tx, this.removeTx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tx.isNotEmpty
        ? ListView.builder(
            itemBuilder: ((context, index) {
              return TransactionItem(
                tx: tx,
                removeTx: removeTx,
                index: index,
              );
            }),
            itemCount: tx.length,
          )
        : const Center(child: Text('No transactions found'));
  }
}
