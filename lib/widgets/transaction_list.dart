import 'package:flutter/material.dart';
import '../provider/transaction.dart';
import '../widgets/transaction_item.dart' as ti;

// ignore: must_be_immutable
class TransactionList extends StatelessWidget {
  final List<TransactionItem> tx;
  const TransactionList(this.tx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return tx.isNotEmpty
        ? ListView.builder(
            itemBuilder: ((context, index) {
              return ti.TransactionItem(
                tx: tx,
                index: index,
              );
            }),
            itemCount: tx.length,
          )
        : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 175,
              width: 175,
              child: Image.asset('assets/illustrations/empty_list.png', )),
              const SizedBox(height: 10),
            const Text('No transactions found'),
          ],
        );
  }
}
