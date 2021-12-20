import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:flutter/material.dart';

class WoundOverviewScreen extends StatefulWidget {
  final Patient patient;
  const WoundOverviewScreen({Key? key, required this.patient})
      : super(key: key);

  @override
  _WoundOverviewState createState() => _WoundOverviewState();
}

class _WoundOverviewState extends State<WoundOverviewScreen> {
  List<Widget> _initWounds(Patient patient) {
    final List<Widget> widgets = [];
    final List<Wound>? wounds = patient.patientFile.wounds;
    if (wounds == null) {
      return widgets;
    }
    for (var wound in wounds) {
      widgets.add(ListTile(
        title: Text("Wound ${wound.id} - ${wound.type}"),
        subtitle: Text(
            "Located at: ${wound.location}\nFirst entry: ${wound.formattedDate()}"),
        isThreeLine: true,
        trailing: Icon(Icons.keyboard_arrow_right),
      ));
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.patient.fullName())),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _initWounds(widget.patient),
          ),
        ),
      ),
    );
  }
}
