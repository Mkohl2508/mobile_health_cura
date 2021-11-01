import 'package:cura/shared/text_input_login_wdiget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xff37ffa5),
          Color(0xff3798ff),
        ],
        begin: Alignment(0, 1),
        end: Alignment(-1.0, -1),
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Text("Welcome to Cura",
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 4.0),
                              blurRadius: 4.0,
                              color: Color.fromARGB(64, 0, 0, 0),
                            )
                          ])),
                  SizedBox(
                    height: 80,
                  ),
                  Icon(
                    Icons.account_circle,
                    size: 150,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextInputLogin(
                    icon: Icon(
                      Icons.person,
                      color: Color(0x7001A1DB),
                      size: 25,
                    ),
                    color: Color(0x7001A1DB),
                    hint: "Username",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextInputLogin(
                    isPassword: true,
                    icon: Icon(
                      Icons.lock,
                      color: Color(0x7001A1DB),
                      size: 25,
                    ),
                    color: Color(0x7001A1DB),
                    hint: "Password",
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
