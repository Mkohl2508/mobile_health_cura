import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient_record.dart';
import 'package:cura/model/residence/residence.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/globals.dart' as globals;
import 'package:cura/model/patient/patient.dart';
import 'package:cura/screens/home_screen.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Room> rooms =
      globals.masterContext.getById("Uoto3xaa5ZL9N2mMjPhG")!.rooms;

  //form values
  String? _firstName;
  String? _lastName;
  DateTime _birthday = DateTime.now();
  Room? _currentRoom;
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cura_darkCyan,
          title: Text('New Patient'),
        ),
        body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a first name' : null,
                          decoration: InputDecoration(
                              hintText: 'First Name',
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          onChanged: (val) {
                            setState(() {
                              _firstName = val;
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a last name' : null,
                          decoration: InputDecoration(
                              hintText: 'Last Name',
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          onChanged: (val) {
                            setState(() {
                              _lastName = val;
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      InputDatePickerFormField(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        onDateSubmitted: (date) {
                          setState(() {
                            _birthday = date;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a Phone Number' : null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Phone Number',
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          onChanged: (val) {
                            setState(() => _phoneNumber = val);
                          }),
                      SizedBox(
                        height: 30,
                      ),
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                              hintText: 'Number',
                              labelText: 'Patient Room',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          items: rooms.map((room) {
                            return DropdownMenuItem(
                              value: room,
                              child: Text('Room ${room.number}'),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() {
                                _currentRoom = value as Room;
                              })),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColors.cura_cyan),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    side: BorderSide(
                                        color: AppColors.cura_cyan)))),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            Patient newPerson = Patient(
                                id: '1',
                                firstName: _firstName,
                                surname: _lastName,
                                birthDate: _birthday,
                                residence: Residence(
                                    id: '1',
                                    city: 'placeholder',
                                    street: 'placeholder',
                                    zipCode: 'placeholder',
                                    country: 'placeholder'),
                                phoneNumber: _phoneNumber,
                                patientFile: PatientRecord(id: '1'));
                            //QueryWrapper.roomsRef.
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }
                        },
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            height: 50,
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(fontSize: 22),
                              ),
                            )),
                      )
                    ])))));
  }
}
