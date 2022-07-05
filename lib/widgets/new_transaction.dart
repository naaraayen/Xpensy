//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class NewTransaction extends StatefulWidget {
  Function getTxInfo;
  NewTransaction(this.getTxInfo, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction>
    with WidgetsBindingObserver {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  late DateTime selectedDate = DateTime.now();
  late bool checkIfSelected = false;

  presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 7)),
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
  }

  void submitData(DateTime chosenDate) {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.getTxInfo(enteredTitle, enteredAmount, chosenDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
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
              onSubmitted: (_) => submitData,
            ),
            TextField(
              keyboardType: TextInputType.number,
              maxLength: 5,
              decoration:
                  const InputDecoration(labelText: 'Enter transaction amount'),
              controller: amountController,
              onSubmitted: (_) => submitData,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(checkIfSelected == false
                    ? 'No date chosen'
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
                submitData(selectedDate);
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
