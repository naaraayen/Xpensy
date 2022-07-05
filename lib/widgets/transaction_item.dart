import 'package:flutter/material.dart';
import 'package:xpensy/models/transaction.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TransactionItem extends StatelessWidget {
  TransactionItem({
    Key? key,
    required this.index,
    required this.tx,
    required this.removeTx,
  }) : super(key: key);
  int index;
  final List<Transaction> tx;
  final Function removeTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsetsDirectional.all(5.0),
      color: Theme.of(context).primaryColor,
      elevation: 10,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        textColor: Colors.white,
        iconColor: Colors.white,
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text(
                'Rs ${tx[index].transactionAmount.toString()}',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        title: Text(
          tx[index].transactionName,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(tx[index].dateTime),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            removeTx(index);
          },
        ),
      ),
    );
  }
}
