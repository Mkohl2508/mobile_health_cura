import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/patient_record_screen.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientScreen extends StatefulWidget {
  final Patient patient;
  const PatientScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  _initView(Map<String, dynamic> data) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Image(
              image: FirebaseImage(
                  'gs://mobile-health-cura.appspot.com/Mueller/old_lady.jpg',
                  shouldCache:
                      true, // The image should be cached (default: True)
                  maxSizeBytes:
                      3000 * 1000, // 3MB max file size (default: 2.5MB)
                  cacheRefreshStrategy:
                      CacheRefreshStrategy.NEVER // Switch off update checking
                  ),
            )),
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
                          data["firstName"] + " " + data["surname"],
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
                            DateFormat('dd.MM.yyyy').format(DateTime.parse(
                                data["birthDate"].toDate().toString())),
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
                            data["residence"]["city"] +
                                "," +
                                data["residence"]["zipCode"] +
                                data["residence"]["street"],
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
    CollectionReference patient = FirebaseFirestore.instance.collection(
        'NursingHome/Uoto3xaa5ZL9N2mMjPhG/Room/8c3fugbbchJ9mhy5RF0H/Patient');
    return FutureBuilder<DocumentSnapshot>(
      future: patient.doc("Wm6hKOszycoOJyFYvxum").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return _initView(data);
        }
        return Text("loading");
      },
    );
  }
}
