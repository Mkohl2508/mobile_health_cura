import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/add_wound_screen.dart';
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
  final _isHealedOpacity = 0.3;

  List<Widget> _initWounds(Patient patient, bool initHealed) {
    final List<Widget> widgets = [];
    final List<Wound>? wounds = patient.patientFile.wounds;
    if (wounds == null) {
      return widgets;
    }
    int woundCounter = 1;
    for (var wound in wounds) {
      if (initHealed ^ wound.isHealed) {
        continue;
      }
      widgets.add(IconTileWidget(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WoundInformationScreen(
              patient: widget.patient,
              wound: wound,
              room: widget.room,
            );
          })).then((value) {
            setState(() {
              _healedWounds = _initWounds(widget.patient, true);
              _notHealedWounds = _initWounds(widget.patient, false);
            });
          });
        },
        leadingWidget: Text(
          woundCounter.toString(),
          style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: wound.isHealed
                  ? Colors.white.withOpacity(_isHealedOpacity)
                  : Colors.white),
        ),
        leadingColor: wound.isHealed
            ? AppColors.cura_cyan.withOpacity(_isHealedOpacity)
            : AppColors.cura_cyan,
        height: 90,
        listInputs: [
          Text(wound.type,
              style: TextStyle(
                  color: wound.isHealed
                      ? Colors.black.withOpacity(_isHealedOpacity)
                      : Colors.black)),
          SizedBox(
            height: 5,
          ),
          Text("Located at: ${wound.location}",
              style: TextStyle(
                  color: wound.isHealed
                      ? Colors.black.withOpacity(_isHealedOpacity)
                      : Colors.black)),
          SizedBox(
            height: 5,
          ),
          Text(
            "Created at: ${wound.formattedDate()}",
            style: TextStyle(
                color: wound.isHealed
                    ? Colors.black.withOpacity(_isHealedOpacity)
                    : Colors.black),
          )
        ],
        trailingIcon: Icon(
          Icons.arrow_forward_ios,
          color: wound.isHealed
              ? Color(0xFF065fc4).withOpacity(_isHealedOpacity)
              : Color(0xFF065fc4),
        ),
      ));
      widgets.add(SizedBox(
        height: 10,
      ));
      woundCounter++;
    }

    return widgets;
  }

  late List<Widget> _healedWounds;
  late List<Widget> _notHealedWounds;

  @override
  void initState() {
    // TODO: implement initState
    _notHealedWounds = _initWounds(widget.patient, false);
    _healedWounds = _initWounds(widget.patient, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddWoundScreen(
              patient: widget.patient,
            );
          })).then((wound) {
            if (wound == null) {
              return;
            }
            setState(() {
              widget.patient.patientFile.wounds!.add(wound);
              _notHealedWounds = _initWounds(widget.patient, false);
            });
          });
        },
      ),
      appBar: AppBar(
          backgroundColor: AppColors.cura_darkCyan,
          title: Text(widget.patient.fullName())),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text("Current wounds",
                    style: TextStyle(
                      fontSize: 14,
                    )),
              ),
              Column(
                children: _notHealedWounds.isEmpty
                    ? [
                        Container(
                          height: 50,
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("There are currently no wounds noted"),
                              SizedBox(
                                width: 3,
                              ),
                              Icon(
                                Icons.check_circle,
                                size: 20,
                                color: Colors.green,
                              )
                            ],
                          ),
                        )
                      ]
                    : _notHealedWounds,
              ),
              _healedWounds.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
                      child: Text("Healed wounds",
                          style: TextStyle(
                            fontSize: 14,
                          )),
                    ),
              Column(
                children: _healedWounds.isEmpty ? [] : _healedWounds,
              )
            ],
          ),
        ),
      ),
    );
  }
}
