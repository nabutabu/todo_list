import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/data/provider/user_provider.dart';
import 'package:todo_list/screens/home.dart';
import 'package:todo_list/screens/login.dart';
import 'package:todo_list/screens/register.dart';
import 'package:todo_list/screens/splash_screen.dart';
import 'package:todo_list/screens/start.dart';
import 'package:todo_list/widgets/checkbox_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => print('Complete'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MaterialApp(
        title: 'ToDo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Home(),
        initialRoute: '/splash_screen',
        routes: {
          '/checkBoxList': (context) => CheckBoxList(),
          '/login': (context) => Login(),
          '/start': (context) => StartScreen(),
          '/register': (context) => RegisterScreen(),
          '/splash_screen': (context) => SplashScreen(),
        },
      ),
    );
  }
}
