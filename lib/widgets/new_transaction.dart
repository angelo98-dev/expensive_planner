import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final _keyForm = GlobalKey<FormState>();

  final titleControler = TextEditingController();
  final amountControler = TextEditingController();

  NewTransaction(this.addTx);

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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Must not be empty';
                      } else {
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
                    addTx(titleControler.text,
                        double.tryParse(amountControler.text));
                  }
                },
                child: const Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
