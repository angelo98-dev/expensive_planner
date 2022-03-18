import 'package:expensive_planner/widgets/new_transaction.dart';
import 'package:expensive_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'model/transaction_model.dart';

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 200.30,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'MacBook Pro',
      amount: 150.30,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });

  }
  void startAddNewTransaction(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (_){
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed:() => startAddNewTransaction(context),
            icon: const Icon(
              Icons.add, color: Colors.white,),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: double.infinity,
              child: const Card(
                child: Text('CHART'),
                color: Colors.blueAccent,
                elevation: 5,
              ),
            ),
            TransactionList(_userTransaction),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );

  }
}
