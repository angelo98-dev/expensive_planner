import 'package:expensive_planner/widgets/new_transaction.dart';
import 'package:expensive_planner/widgets/transaction_list.dart';
import 'package:expensive_planner/widgets/user_transaction.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expensive Planner'),
      ),
      body: Column(
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
          UserTransaction()
        ],
      ),
    );
  }
}
