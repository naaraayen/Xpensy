import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xpensy/bloc/transaction_bloc.dart';
import '../widgets/transaction_item.dart' as ti;

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
      if (state is TransactionLoaded) {
        return state.transactionList.isNotEmpty
            ? ListView.builder(
                itemBuilder: ((context, index) {
                  return ti.TransactionItem(
                    tx: state.transactionList,
                    index: index,
                  );
                }),
                itemCount: state.transactionList.length,
              )
            : Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 175,
                          width: 175,
                          child: Image.asset(
                            'assets/illustrations/empty_list.png',
                          )),
                      const SizedBox(height: 10),
                      const Text('No transactions found'),
                    ],
                  ),
              ),
            );
      }

      return const Center(
        child: Text('Something Went Wrong'),
      );
    });
  }
}
