import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction_model.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> userTransaction;
  TransactionList(this.userTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (_, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: FittedBox(
                    child: Text(
                      '${userTransaction[index].amount} €'
                    ),
                  ),
                ),
              ),
              title: Text(userTransaction[index].title,
              style: Theme.of(context).textTheme.headline6,),
              subtitle: Text(DateFormat.yMMMd().format(userTransaction[index].date)),
            ),
          );
        },
        itemCount: userTransaction.length,

      ),
    );
  }
}
