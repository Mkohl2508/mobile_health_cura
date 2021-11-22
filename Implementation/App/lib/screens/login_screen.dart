import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/home_screen.dart';
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.cura_background,
        body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 20),
                  child: Image(
                    image: AssetImage("assets/cura_logo.png"),
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      TextInputLogin(
                        icon: Icon(
                          Icons.person,
                          color: AppColors.cura_orange,
                          size: 25,
                        ),
                        color: AppColors.cura_orange,
                        hint: "Username",
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInputLogin(
                        isPassword: true,
                        icon: Icon(
                          Icons.lock,
                          color: AppColors.cura_orange,
                          size: 25,
                        ),
                        color: AppColors.cura_orange,
                        hint: "Password",
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.cura_orange),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    side: BorderSide(
                                        color: AppColors.cura_orange)))),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 22),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(134, 118, 102, 0.5)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    side: BorderSide(
                                        color: Color.fromRGBO(
                                            134, 118, 102, 0.5))))),
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Sign up",
                                style: TextStyle(fontSize: 22),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ]),
        ));
  }
}
