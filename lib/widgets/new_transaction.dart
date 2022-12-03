import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/transaction.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction({Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction>
    with WidgetsBindingObserver {
  final amountFocus = FocusNode();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  late DateTime selectedDate = DateTime.now();
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

        selectedDate = pickedDate;
      });
    });
    amountFocus.unfocus();
  }

  void submitData(DateTime chosenDate, Transaction txData) {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    txData.txInfo(enteredTitle, enteredAmount, chosenDate);
    Navigator.of(context).pop();
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
    final txData = Provider.of<Transaction>(context, listen: false);
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
                Text(checkIfSelected == false
                    ? 'No date chosen (default: today)'
                    : DateFormat.yMMMd().format(selectedDate).toString()),
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
              child: const Text(
                'Add transaction',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
