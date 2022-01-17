import 'package:cura/model/enums/enum_converter.dart';
import 'package:cura/model/enums/form_enum.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddWoundScreen extends StatefulWidget {
  final Patient patient;

  const AddWoundScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _AddWoundScreenState createState() => _AddWoundScreenState();
}

class _AddWoundScreenState extends State<AddWoundScreen> {
  String currentDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
  FormEnum? _form;
  TextEditingController _typeController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 17),
            Container(
              height: 40,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 3))
              ]),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                      child: Center(
                          child: Text(
                    "Date: $currentDate",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ))),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                "Wound information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: TextFormField(
                controller: _typeController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    hintText: 'Which type of wound?',
                    labelText: 'Wound type',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: TextFormField(
                controller: _locationController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    hintText: 'Where is the wound located?',
                    labelText: 'Wound location',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0),
                      hintText: "Choose a wound edge",
                      labelText: "Wound edge",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  onChanged: (value) {
                    setState(() {
                      _form = EnumConverter.stringToFormEnum(value.toString());
                    });
                  },
                  items: getFormList().map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item.toString()),
                    );
                  }).toList(),
                )),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.cura_cyan),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            side: BorderSide(color: AppColors.cura_cyan)))),
                onPressed: () {
                  //check the values
                  if (_typeController.text.isEmpty) {
                    _showSnackBar("Please enter a wound type");
                    return;
                  } else if (_locationController.text.isEmpty) {
                    _showSnackBar("Please enter a wound location");
                    return;
                  } else if (_form == null) {
                    _showSnackBar("Please choose a wound form");
                    return;
                  }

                  Wound wound = Wound(
                      id: Uuid().v1(),
                      isHealed: false,
                      type: _typeController.text,
                      location: _locationController.text,
                      form: _form,
                      isChronic: false,
                      startDate: DateTime.now());

                  Navigator.pop(context, wound);
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
                          Icons.save,
                          size: 26,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Save"),
                      ],
                    ))),
              ),
            ),
          ],
        ),
      )),
    );
  }

  void _showSnackBar(String s) {
    final snackBar = SnackBar(
      content: Text(s),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
