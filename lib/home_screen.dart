import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expensive Planner'),
      ),

      body: Column(
        children: const [
          Card(
            child: Text('CHART'),
          ),

          Card(
            child: Text('LIST OF TX'),
          )
        ],
      ),
    );
  }
}