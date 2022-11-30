import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/transaction.dart' as pti;
import '../provider/transaction.dart';
import '../widgets/neumorphic_container.dart';

// ignore: must_be_immutable
class TransactionItem extends StatelessWidget {
  TransactionItem({
    Key? key,
    required this.index,
    required this.tx,
  }) : super(key: key);
  int index;
  final List<pti.TransactionItem> tx;

  @override
  Widget build(BuildContext context) {
    final txData = Provider.of<Transaction>(context, listen: false);
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
              txData.removeTx(index);
            },
          ),
        ),
      ),
    );
  }
}
