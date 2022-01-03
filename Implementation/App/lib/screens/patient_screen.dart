import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/patient_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';

class PatientScreen extends StatefulWidget {
  final Patient patient;
  const PatientScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  _initView() {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image:
                    'https://firebasestorage.googleapis.com/v0/b/mobile-health-cura.appspot.com/o/Mueller%2Fold_lady.jpg?alt=media&token=f35f17c5-a2f9-4c02-bff3-a7d9bbfb8b5d',
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Personal information",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(0xFFe2e2e2)))),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "First name, surname",
                          style: TextStyle(color: Colors.black, height: 1.5),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.patient.fullName(),
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
                        Text("Date of birth (DD-MM-YYYY)",
                            style: TextStyle(height: 1.5, color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(widget.patient.formattedBirthday(),
                            style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 25, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Place of residence",
                            style: TextStyle(height: 1.5, color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "${widget.patient.residence.street}, ${widget.patient.residence.zipCode} ${widget.patient.residence.city}",
                            style: TextStyle(
                                color: Colors.grey[700], height: 1.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Attending Doctor",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(0xFFe2e2e2)))),
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Title. first name, surname",
                            style: TextStyle(color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.patient.patientFile.attendingDoctor!
                              .fullName(),
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
                        Text("Date of birth (DD-MM-YYYY)",
                            style: TextStyle(height: 1.5, color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            widget.patient.patientFile.attendingDoctor!
                                .formattedBirthday(),
                            style: TextStyle(color: Colors.grey[700])),
                      ],
                    ),
                  ),
                  Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 25, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Location of the doctor's office",
                            style: TextStyle(height: 1.5, color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            widget
                                .patient.patientFile.attendingDoctor!.residence
                                .getAddress(),
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
                    padding:
                        const EdgeInsets.only(left: 20, right: 25, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Phone number",
                            style: TextStyle(height: 1.5, color: Colors.black)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            widget.patient.patientFile.attendingDoctor!
                                .phoneNumber!,
                            style: TextStyle(
                                color: Colors.grey[700], height: 1.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PatientRecordScreen(
                          patient: widget.patient,
                        )));
              },
              child: Container(
                width: 700,
                height: 70,
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      color: AppColors.cura_cyan,
                      width: 50,
                      child: Center(
                        child: Icon(
                          Icons.checklist_rtl_rounded,
                          color: Colors.white,
                          size: 27,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Patient record",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Last update: 12.11.2021, 13:40",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    )),
                    Container(
                      width: 80,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFF065fc4),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return _initView();
  }
}
