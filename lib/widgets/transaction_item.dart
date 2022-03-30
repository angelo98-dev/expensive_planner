import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.userTransaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction userTransaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                  '${userTransaction.amount} €'
              ),
            ),
          ),
        ),
        title: Text(userTransaction.title,
          style: Theme.of(context).textTheme.headline6,),
        subtitle: Text(DateFormat.yMMMd().format(userTransaction.date)),
        trailing: MediaQuery.of(context).size.width > 450 ?
        TextButton.icon(
          onPressed: () => deleteTx(userTransaction.id),
          icon: const Icon(Icons.delete_outline),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Theme.of(context).errorColor,)),
          label: const Text('Delete'),) :

        IconButton(
          icon: Icon(Icons.delete_outline,
            color: Theme.of(context).errorColor,),
          onPressed: () => deleteTx(userTransaction.id),
        ),
      ),
    );
  }
}