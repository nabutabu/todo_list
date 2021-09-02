import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/widgets/checkbox_list.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: Home(),
      initialRoute: '/',
      routes: {
        '/checkBoxList': (context) => const CheckBoxList(),
      },
    );
  }
}
