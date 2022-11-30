import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/chart.dart';
import '../widgets/new_transaction.dart';
import '../provider/transaction.dart';
import '../widgets/transaction_list.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);


  var _showChart = false;

  addNewTransaction(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).primaryColorLight,
        context: context,
        builder: (ctx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: const NewTransaction());
        });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, Widget txList, List<TransactionItem> recentTransaction) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show Chart'),
          Switch(
              value: _showChart,
              onChanged: (newValue) {
                  _showChart = newValue;
              })
        ],
      ),
      _showChart
          ? Container(
              padding: const EdgeInsets.all(8.0),
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.8,
              child: Chart(
                recentTransactions: recentTransaction,
              ),
            )
          : txList
    ];
  }

  List<Widget> _buildPortaitContent(MediaQueryData mediaQuery, Widget txList, List<TransactionItem> recentTransaction) {
    return [
      Container(
        padding: const EdgeInsets.all(8.0),
        height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.3,
        child: Chart(
          recentTransactions: recentTransaction,
        ),
      ),
      txList,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final txData = Provider.of<Transaction>(context,);
    final txList = Container(
        padding: const EdgeInsets.all(8.0),
        height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.7,
        child: TransactionList(txData.tx));
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addNewTransaction(context);
        },
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (isLandscape) ..._buildLandscapeContent(mediaQuery, txList, txData.recentTransaction
            ),
            if (!isLandscape) ..._buildPortaitContent(mediaQuery, txList, txData.recentTransaction)
          ]),
        ),
      )),
    );
  }
}
