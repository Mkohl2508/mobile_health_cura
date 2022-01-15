import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cura/model/general/old_people_home.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient_record.dart';
import 'package:cura/model/residence/residence.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/globals.dart' as globals;
import 'package:cura/model/patient/patient.dart';
import 'package:cura/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'full_screen_screen.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  late OldPeopleHome oldPeopleHome;
  late List<Room> rooms;

  //form values

  Room? _currentRoom;
  File? _profilePic;
  DateTime? _birthdate;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    oldPeopleHome = globals.masterContext.getById(QueryWrapper.nursingHomeID)!;
    rooms = oldPeopleHome.rooms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _imgFromCamera() async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      if (!mounted) return;
      setState(() {
        if (image != null) {
          _profilePic = File(image.path);
        }
      });
    }

    _imgFromGallery() async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (!mounted) return;
      setState(() {
        if (image != null) {
          _profilePic = File(image.path);
        }
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      leading: Icon(Icons.photo_camera),
                      title: Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    List<String> roomList = createDropdownList(rooms);
    if (roomList.isEmpty) {
      print('empty');
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cura_darkCyan,
          title: Text('New Patient'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  _profilePic == null
                      ? Image.asset("assets/no-image.jpg")
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return FullScreenImage(imageFile: _profilePic);
                            }));
                          },
                          child: Center(
                            child: Hero(
                                tag: "imageHero",
                                child: Image.file(
                                  _profilePic!,
                                )),
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.cura_cyan),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40.0),
                                      side: BorderSide(
                                          color: AppColors.cura_cyan)))),
                      onPressed: () {
                        _showPicker(context);
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
                                Icons.photo_camera,
                                size: 26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Add picture"),
                            ],
                          ))),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: _firstNameController,
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a first name' : null,
                    decoration: InputDecoration(
                        hintText: 'First Name',
                        labelText: 'First Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a last name' : null,
                    decoration: InputDecoration(
                        hintText: 'Last Name',
                        labelText: 'Last Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Phone number (optional)',
                        labelText: 'Phone number (optional)',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _birthdayController,
                    keyboardType: TextInputType.none,
                    showCursor: false,
                    readOnly: true,
                    onTap: () async {
                      _birthdate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900, 1, 1),
                          lastDate: DateTime.now());

                      _birthdayController.text =
                          DateFormat('dd.MM.yyyy').format(_birthdate!);
                    },
                    validator: (val) =>
                        val!.isEmpty ? 'Enter a birthdate' : null,
                    decoration: InputDecoration(
                        hintText: 'Birthdate',
                        labelText: 'Birthdate',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
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
                          child: Text('Room ${room.number.toString()}'),
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
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: AppColors.cura_cyan)))),
                    onPressed: () async {
                      if (_currentRoom == null) {
                        // room not set
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        if (_currentRoom == null) {
                          _showSnackBar("Please select a room");
                        }

                        if (_profilePic == null) {
                          _showSnackBar("Please add a profile picture");
                        }

                        String profilePicUrl = await QueryWrapper.uploadImage(
                            _profilePic!,
                            "${_firstNameController.text} ${_lastNameController.text}/ProfilePic");

                        Patient newPerson = Patient(
                            profilePic: profilePicUrl,
                            firstName: _firstNameController.text,
                            surname: _lastNameController.text,
                            roomId: _currentRoom!.id!,
                            birthDate: DateFormat('dd.MM.yyyy')
                                .parse(_birthdayController.text),
                            residence: oldPeopleHome.residence,
                            phoneNumber: _numberController.text.isEmpty
                                ? null
                                : _numberController.text,
                            patientFile: PatientRecord());

                        await QueryWrapper.postPatient(newPerson);

                        // _currentRoom!.patients!.add(newPerson);
                        //globals.masterContext.oldPeopleHomesList[0].
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
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
                ]))));
  }

  void _showSnackBar(String s) {
    final snackBar = SnackBar(
      content: Text(s),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

createDropdownList(List<Room> rooms) {
  List<String>? newList = [];
  for (var room in rooms) {
    newList.add(room.number.toString());
  }
  return newList;
}
