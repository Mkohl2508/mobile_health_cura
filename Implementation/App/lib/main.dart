import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/general/local_user.dart';
import 'package:cura/model/residence/residence.dart';
import 'package:cura/screens/loading_screen.dart';
import 'package:cura/screens/login_screen.dart';
import 'package:cura/utils/auth_helper.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
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
        ),
        home: MainScreen());
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            QueryWrapper.postOrUpdateUser(snapshot.data!);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(snapshot.data!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData &&
                    snapshot.data != null &&
                    snapshot.data!.exists) {
                  final user = LocalUser.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>);
                  return LoadingScreen(user: user);
                } else {
                  return Material(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            );
          }
          return LoginScreen();
        });
  }
}
