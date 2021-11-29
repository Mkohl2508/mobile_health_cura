import 'package:flutter/material.dart';

class PatientRecordScreen extends StatefulWidget {
  const PatientRecordScreen({Key? key}) : super(key: key);

  @override
  _PatientRecordScreenState createState() => _PatientRecordScreenState();
}

class _PatientRecordScreenState extends State<PatientRecordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image(
              image: AssetImage("assets/cura_header.png"),
            ),
          ),
        ),
      ),
    );
  }
}
