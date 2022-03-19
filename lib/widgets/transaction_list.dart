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
            child: Row(
              children: [
                Container(
                  child: Text(
                    '${userTransaction[index].amount.toStringAsFixed(2)} €',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      color: Theme.of(context).colorScheme.primary
                       ),
                  ),
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userTransaction[index].title,
                      style: Theme.of(context).textTheme.headline6
                    ),
                    Text(
                      DateFormat('dd MMM, yyyy').format(userTransaction[index].date),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );

        },
        itemCount: userTransaction.length,

      ),
    );
  }
}
