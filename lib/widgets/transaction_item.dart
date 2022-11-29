import 'package:flutter/material.dart';
import 'package:xpensy/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:xpensy/widgets/neumorphic_container.dart';

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
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: NeumorphicContainer(
        color: Colors.grey.shade200,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          leading: NeumorphicContainer(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FittedBox(
                child: Text(
                  'Rs${tx[index].transactionAmount.toString()}',
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
      ),
    );
  }
}
