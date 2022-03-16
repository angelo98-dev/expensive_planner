import 'package:flutter/material.dart';

import 'home_screen.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Expensive Planner',
      home: MyHomePage(),
    );
  }
}
