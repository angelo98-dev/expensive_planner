import 'dart:io';
import 'dart:developer' as developer;

import 'package:expensive_planner/widgets/chart.dart';
import 'package:expensive_planner/widgets/new_transaction.dart';
import 'package:expensive_planner/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/transaction_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {


  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    developer.log(state.toString(),name: "MyApp");
  }

  final List<Transaction> _userTransaction = [];
  var _showChart = false;

  List<Transaction>? get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == id);
    });
  }

  void startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<Widget> _buildLandScapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txtList) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Show Chart'),
          Switch.adaptive(
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      (mediaQuery.padding.top)) *
                  0.7,
              child: Chart(_recentTransactions!))
          : txtList,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txtList) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  (mediaQuery.padding.top)) *
              0.3,
          child: Chart(_recentTransactions!)),
      txtList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;

    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: GestureDetector(
              onTap: () => startAddNewTransaction(context),
              child: const Icon(CupertinoIcons.add),
            ),
          )
        : AppBar(
            title: const Text('Personal Expenses'),
            actions: [
              IconButton(
                onPressed: () => startAddNewTransaction(context),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          );

    final txtList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                (mediaQuery.padding.top)) *
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape)
              ..._buildLandScapeContent(mediaQuery, appBar, txtList),
            if (!isLandScape)
              ..._buildPortraitContent(mediaQuery, appBar, txtList)
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(navigationBar: appBar, child: pageBody)
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => startAddNewTransaction(context),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
          );
  }
}
