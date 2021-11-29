import 'package:cura/model/residence/residence.dart';
import 'package:cura/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CuraApp());
}

class CuraApp extends StatelessWidget {
  const CuraApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cura',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Color.fromRGBO(134, 118, 102, 1),
              displayColor: Color.fromRGBO(134, 118, 102, 1)),
        ),
        home: LoginScreen());
  }
}
