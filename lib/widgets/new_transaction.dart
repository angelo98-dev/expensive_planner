import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _keyForm = GlobalKey<FormState>();

  final titleControler = TextEditingController();

  final amountControler = TextEditingController();

  void submitData(){
    final enteredTitle = titleControler.text;
    final enteredAmount = amountControler.text;

    widget.addTx(enteredTitle,double.tryParse(enteredAmount));
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Form(
              key: _keyForm,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: titleControler,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Must not be empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Amount',
                    ),
                    controller: amountControler,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Must not be empty';
                      } else if (double.parse(amountControler.text) <= 0) {
                        return 'Not a valid amount';
                    } else{
                        return null;
                      }
                    },
                  ),
                ],
              ),
            ),
            TextButton(
                style: TextButton.styleFrom(primary: Colors.purple),
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    submitData();
                  }
                },
                child: const Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
