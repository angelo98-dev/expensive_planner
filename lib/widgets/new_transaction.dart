import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx){
    developer.log("Constructor NewTransaction",name: "NewTransaction");
  }

  @override
  State<NewTransaction> createState(){
    developer.log("createState NewTransaction",name: "NewTransaction");
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  _NewTransactionState(){
    developer.log("Constructor NewTransaction State",name: "NewTransaction");
  }


  @override
  void initState() {
    developer.log("initState()",name: "NewTransaction");
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    developer.log("didUpdateWidget()",name: "NewTransaction");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    developer.log("dispose()",name: "NewTransaction");
    super.dispose();
  }

  final _keyForm = GlobalKey<FormState>();

  final _titleControler = TextEditingController();

  final _amountControler = TextEditingController();
  DateTime? _selectedDate;
  void _submitData(){

    final enteredTitle = _titleControler.text;
    final enteredAmount = _amountControler.text;

    if(_selectedDate == null){
      return;
    }
    widget.addTx(
        enteredTitle,
        double.tryParse(enteredAmount),
    _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime.now()).then((pickedDate){
          if(pickedDate == null){
            return;
          }
          setState(() {
            _selectedDate = pickedDate;
          });



    });
  }


  @override
  Widget build(BuildContext context) {

    developer.log("build()",name: "NewTransaction");

    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 10,left: 10,right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
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
                      controller: _titleControler,
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
                      controller: _amountControler,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty ) {
                          return 'Must not be empty';
                        } else if (double.parse(_amountControler.text) <= 0) {
                          return 'Not a valid amount';
                      } else{
                          return null;
                        }
                      },
                    ),
                    Row(
                      children: [

                        Expanded(
                          child: Text(_selectedDate == null ?
                          'No Date Chosen' :
                          'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                        ),
                        TextButton(
                            onPressed: _presentDatePicker,
                            child: Text('Choose Date'),
                            style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.primary),)
                      ],
                    )
                  ],
                ),
              ),
              ElevatedButton(
                  //style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.primary),
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _submitData();
                    }
                  },
                  child: const Text('Add Transaction'))
            ],
          ),
        ),
      ),
    );
  }
}
