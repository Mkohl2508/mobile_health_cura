import 'package:cura/model/general/room.dart';
import 'package:flutter/material.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/globals.dart' as globals;

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
  String? _name;
  int? _currentRoomNumber;
  DateTime? _birthday;

  @override
  Widget build(BuildContext context) {
    List<String> roomList = createDropdownList(rooms);
    if (roomList.isEmpty) {
      print('empty');
    }
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
                              val!.isEmpty ? 'Enter a firs name' : null,
                          decoration: InputDecoration(
                              hintText: 'First Name',
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          onChanged: (val) {}),
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
                          onChanged: (val) {}),
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
                      DropdownButtonFormField(
                          decoration: InputDecoration(
                              hintText: 'Number',
                              labelText: 'Patient Room',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                          items: roomList.map((number) {
                            return DropdownMenuItem(
                              value: number,
                              child: Text('Room $number'),
                            );
                          }).toList(),
                          onChanged: (value) => setState(() {
                                //_currentRoomNumber = int.tryParse(value);
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
                          if (_formKey.currentState!.validate()) {}
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

createDropdownList(List<Room> rooms) {
  List<String>? newList = [];
  for (var room in rooms) {
    newList.add(room.number.toString());
  }
  return newList;
}
