import 'package:flutter/material.dart';


import '../model/transaction_model.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> userTransaction;
  final Function deleteTx;
  const TransactionList(this.userTransaction,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return userTransaction.isEmpty ?
      LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/bag.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'No transactions added yet !',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ],
            ),
          );
        },
      )
      : ListView.builder(
        itemBuilder: (_, index) {
          return TransactionItem(userTransaction: userTransaction[index], deleteTx: deleteTx);
        },
        itemCount: userTransaction.length,
    );
  }
}


