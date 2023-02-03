import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xpensy/bloc/transaction_bloc.dart';
import 'package:xpensy/models/transaction_model.dart';
import '../widgets/neumorphic_container.dart';
import 'new_transaction.dart';

// ignore: must_be_immutable
class TransactionItem extends StatelessWidget {
  TransactionItem({
    Key? key,
    required this.index,
    required this.tx,
  }) : super(key: key);
  int index;
  final List<TransactionModel> tx;

  addNewTransaction(BuildContext context, TransactionModel tx) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).primaryColorLight,
        context: context,
        builder: (ctx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(
                isNew: false,
                id: tx.id,
                title: tx.transactionName,
                amount: tx.transactionAmount.toString(),
                dateTime: tx.dateTime,
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: NeumorphicContainer(
        color: Colors.grey.shade200,
        offset: 2,
        blurRadius: 4,
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
            tx[index].dateTime,
          ),
          trailing: Wrap(children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                addNewTransaction(context, tx[index]);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context
                    .read<TransactionBloc>()
                    .add(TransactionDelete(transactionId: tx[index].id));
              },
            ),
          ]),
        ),
      ),
    );
  }
}
