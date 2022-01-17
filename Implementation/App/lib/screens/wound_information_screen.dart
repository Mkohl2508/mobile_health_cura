import 'package:cura/model/enums/enum_converter.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/wound_entry_screen.dart';
import 'package:cura/shared/icon_tile_widget.dart';
import 'package:flutter/material.dart';

class WoundInformationScreen extends StatefulWidget {
  final Room room;
  final Patient patient;
  final Wound wound;

  const WoundInformationScreen(
      {Key? key,
      required this.room,
      required this.patient,
      required this.wound})
      : super(key: key);

  @override
  _WoundInformationScreenState createState() => _WoundInformationScreenState();
}

class _WoundInformationScreenState extends State<WoundInformationScreen> {
  void _sortByDate() {
    widget.wound.woundEntrys!.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  void initState() {
    // TODO: implement initState
    _sortByDate();
    super.initState();
  }

  final Widget _isHealedLabel = Row(
    children: [
      Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 20,
      ),
      SizedBox(
        width: 3,
      ),
      Text(
        "is healed",
        style: TextStyle(color: Colors.green),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cura_darkCyan,
        title: Text(
          widget.patient.fullName(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Wound information",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    widget.wound.isHealed ? _isHealedLabel : Container()
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFe2e2e2)))),
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 25, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("First reported date",
                              style:
                                  TextStyle(height: 1.5, color: Colors.black)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.wound.formattedDate(),
                              style: TextStyle(
                                  color: Colors.grey[700], height: 1.5)),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Wound type",
                            style: TextStyle(color: Colors.black, height: 1.5),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.wound.type,
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Located at",
                              style:
                                  TextStyle(height: 1.5, color: Colors.black)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(widget.wound.location,
                              style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Wound form",
                              style:
                                  TextStyle(height: 1.5, color: Colors.black)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              EnumConverter.formEnumToString(
                                  widget.wound.form!),
                              style: TextStyle(color: Colors.grey[700])),
                        ],
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 25, bottom: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Is chronic?",
                              style:
                                  TextStyle(height: 1.5, color: Colors.black)),
                          SizedBox(
                            height: 5,
                          ),
                          widget.wound.isChronic == null
                              ? Text("Not set",
                                  style: TextStyle(
                                      color: Colors.grey[700], height: 1.5))
                              : (widget.wound.isChronic!
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.warning,
                                          color: Colors.yellow[600],
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("Yes",
                                            style: TextStyle(
                                                color: Colors.grey[700],
                                                height: 1.5)),
                                      ],
                                    )
                                  : Text("No",
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          height: 1.5))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              IconTileWidget(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return WoundEntryScreen(
                      patient: widget.patient,
                      wound: widget.wound,
                      room: widget.room,
                    );
                  }));
                },
                leadingWidget: Icon(
                  Icons.healing,
                  color: Colors.white,
                ),
                leadingColor: AppColors.cura_cyan,
                height: 70,
                listInputs: [
                  Text(
                    "Wound entries",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                      "Last update: ${widget.wound.woundEntrys!.isEmpty ? "-" : widget.wound.woundEntrys!.last.formattedDate()}"),
                ],
                trailingIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF065fc4),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.cura_darkBlue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                              side:
                                  BorderSide(color: AppColors.cura_darkBlue)))),
                  onPressed: () {
                    // set up the buttons
                    Widget cancelButton = TextButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
                    Widget continueButton = TextButton(
                      child: Text("Continue"),
                      onPressed: () {
                        widget.wound.isHealed = true;
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );

                    // set up the AlertDialog
                    AlertDialog alert = AlertDialog(
                      title: Text("Wound is healed"),
                      content: Text(
                          "After this action, the wound is considered healed. You cannot add any more entries afterwards.\n\nWould you like to continue?"),
                      actions: [
                        cancelButton,
                        continueButton,
                      ],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 60,
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.health_and_safety,
                            size: 26,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Wound is healed"),
                        ],
                      ))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
