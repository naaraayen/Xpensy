import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:xpensy/bloc/transaction_bloc.dart';
import 'package:xpensy/models/transaction_model.dart';

class NewTransaction extends StatefulWidget {
  bool isNew;
  String? id;
  String? title;
  String? amount;
  String? dateTime;
  NewTransaction({
    Key? key,
    this.isNew = true,
    this.id,
    this.title,
    this.amount,
    this.dateTime,
  }) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction>
    with WidgetsBindingObserver {
  final amountFocus = FocusNode();
  late TextEditingController titleController;
  late TextEditingController amountController;

  late String selectedDate;
  late bool checkIfSelected = false;

  presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 6)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        checkIfSelected = true;

        selectedDate = pickedDate.toString().split(' ').first;
        widget.dateTime = selectedDate;
      });
    });
    amountFocus.unfocus();
  }

  void submitData(String chosenDate, TransactionBloc txData) {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    final tx = TransactionModel(
        id: widget.id ?? DateTime.now().toIso8601String(),
        transactionName: enteredTitle,
        transactionAmount: enteredAmount,
        dateTime: chosenDate.toString().split(' ').first);
    if (!widget.isNew) {
      txData.add(TransactionEdit(transaction: tx, id: tx.id));
      Navigator.of(context).pop();
      return;
    }
    txData.add(TransactionAdd(transaction: tx));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    selectedDate =
        widget.dateTime ?? DateTime.now().toString().split(' ').first;
    titleController = TextEditingController(text: widget.title);
    amountController = TextEditingController(text: widget.amount);
    super.initState();
  }

  @override
  void dispose() {
    amountFocus.dispose();
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final txData = context.read<TransactionBloc>();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.0),
        child: Column(
          children: [
            TextField(
              maxLength: 50,
              decoration:
                  const InputDecoration(labelText: 'Enter transaction title'),
              controller: titleController,
              onSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(amountFocus),
            ),
            TextField(
              focusNode: amountFocus,
              keyboardType: TextInputType.number,
              maxLength: 5,
              decoration:
                  const InputDecoration(labelText: 'Enter transaction amount'),
              controller: amountController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.dateTime ??
                    (checkIfSelected == false
                        ? 'No date chosen (default: today)'
                        : selectedDate)),
                TextButton(
                    onPressed: presentDatePicker,
                    child: Text(
                      'Pick a date',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ))
              ],
            ),
            TextButton(
              onPressed: () {
                submitData(selectedDate, txData);
              },
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
              child: Text(
                widget.isNew? 'Add transaction' : 'Update transaction',
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
