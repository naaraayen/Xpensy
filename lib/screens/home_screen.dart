import 'package:flutter/material.dart';
import 'package:xpensy/widgets/transaction_list.dart';
import '../widgets/new_transaction.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  addNewTransaction(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).primaryColorLight,
        context: context,
        builder: (ctx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child:  NewTransaction());
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addNewTransaction(context);
        },
      ),
      body: SafeArea(
          child: Padding(
            padding:  const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Column(
              children: const [
                // TODO: Implement Chart
                // Chart
                 Expanded(child: TransactionList()),
              ],
            ),
          )),
    );
  }
}
