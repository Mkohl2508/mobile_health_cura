import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Welcome to Cura", style: TextStyle(fontSize: 40)),
            Column(
              children: [
                Text("Progress is loading..."),
                SizedBox(
                  height: 15,
                ),
                CircularProgressIndicator(),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
