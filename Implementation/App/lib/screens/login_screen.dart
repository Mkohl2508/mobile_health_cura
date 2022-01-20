import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/shared/text_input_login_widget.dart';
import 'package:cura/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  User? user;

  @override
  void initState() {
    _auth.userChanges().listen(
      (event) {
        if (!mounted) return;
        setState(() => user = event);
      },
    );
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.cura_background,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 35, top: 20),
                      child: SvgPicture.asset("assets/cura_logo.svg",
                          color: Color(0xFF0077B6))),
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
                          controller: _emailController,
                          icon: Icon(
                            Icons.person,
                            color: AppColors.cura_cyan,
                            size: 25,
                          ),
                          color: AppColors.cura_cyan,
                          hint: "Username",
                          validator: (String? value) {
                            if (value!.isEmpty) return 'Please enter some text';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextInputLogin(
                          controller: _passwordController,
                          isPassword: true,
                          icon: Icon(
                            Icons.lock,
                            color: AppColors.cura_cyan,
                            size: 25,
                          ),
                          color: AppColors.cura_cyan,
                          hint: "Password",
                          validator: (String? value) {
                            if (value!.isEmpty) return 'Please enter some text';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColors.cura_cyan),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      side: BorderSide(
                                          color: AppColors.cura_cyan)))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                                print("Email and password cannot be empty");
                                return;
                              }
                              try {
                                final user = await AuthHelper.signInWithEmail(
                                    email: _emailController.text,
                                    password: _passwordController.text);
                                if (user != null) {
                                  print("login successful");
                                }
                              } on FirebaseAuthException catch (error) {
                                switch (error.code) {
                                  case "user-not-found":
                                  case "invalid-email":
                                  case "wrong-password":
                                    print("Wrong email/password combination.");
                                    break;
                                }
                              }
                            }
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
                          height: 50,
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
          ),
        ));
  }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }
}
