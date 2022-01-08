import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/wound_information_screen.dart';
import 'package:cura/shared/icon_tile_widget.dart';
import 'package:flutter/material.dart';

class WoundOverviewScreen extends StatefulWidget {
  final Patient patient;
  final Room room;
  const WoundOverviewScreen(
      {Key? key, required this.patient, required this.room})
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
    int woundCounter = 1;
    for (var wound in wounds) {
      widgets.add(IconTileWidget(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WoundInformationScreen(
              patient: widget.patient,
              room: widget.room,
              wound: wound,
              woundEntrys: wound.woundEntrys!,
            );
          }));
        },
        leadingWidget: Text(
          woundCounter.toString(),
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leadingColor: AppColors.cura_cyan,
        height: 90,
        listInputs: [
          Text(wound.type),
          SizedBox(
            height: 5,
          ),
          Text("Located at: ${wound.location}"),
          SizedBox(
            height: 5,
          ),
          Text("First entry: ${wound.formattedDate()}")
        ],
        trailingIcon: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFF065fc4),
        ),
      ));
      widgets.add(SizedBox(
        height: 10,
      ));
      woundCounter++;
    }

    return widgets;
  }

//TODO: add a seperation of healed and unhealed wounds

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.patient.fullName())),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 30),
                child: Text("Registered Wounds",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Column(
                children: _initWounds(widget.patient),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
