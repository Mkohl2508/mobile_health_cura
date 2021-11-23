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
      body: Center(
        child: Text('PatienFileScreen'),
      ),
    );
  }
}
