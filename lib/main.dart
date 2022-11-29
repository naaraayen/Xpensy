import 'package:flutter/material.dart';
import 'package:xpensy/widgets/chart.dart';
import 'package:xpensy/widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(const Xpensy());
}

// ignore: must_be_immutable
class Xpensy extends StatelessWidget {
  const Xpensy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpensy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          colorScheme: ColorScheme.fromSwatch(accentColor: Colors.grey.shade300)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _tx = [];

  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _tx.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _txInfo(String getTitle, double getAmount, DateTime getPickedDate) {
    setState(() {
      _tx.add(Transaction(
          id: DateTime.now().toString(),
          transactionName: getTitle,
          transactionAmount: getAmount,
          dateTime: getPickedDate));
    });
  }

  addNewTransaction(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Theme.of(context).primaryColorLight,
        context: context,
        builder: (ctx) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_txInfo));
        });
  }

  _removeTx(int index) {
    setState(() {
      _tx.removeAt(index);
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, Widget txList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show Chart'),
          Switch(
              value: _showChart,
              onChanged: (newValue) {
                setState(() {
                  _showChart = newValue;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              padding: const EdgeInsets.all(8.0),
              height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.8,
              child: Chart(
                recentTransactions: _recentTransaction,
              ),
            )
          : txList
    ];
  }

  List<Widget> _buildPortaitContent(MediaQueryData mediaQuery, Widget txList) {
    return [
      Container(
        padding: const EdgeInsets.all(8.0),
        height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.3,
        child: Chart(
          recentTransactions: _recentTransaction,
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
    final txList = Container(
        padding: const EdgeInsets.all(8.0),
        height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.7,
        child: TransactionList(_tx, _removeTx));
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      //Theme.of(context).primaryColorLight,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          addNewTransaction(context);
        },
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child:
            Padding(
              padding: const EdgeInsets.fromLTRB(8,8,8,0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (isLandscape) ..._buildLandscapeContent(mediaQuery, txList),
          if (!isLandscape) ..._buildPortaitContent(mediaQuery, txList)
        ]),
            ),
      )),
    );
  }
}
