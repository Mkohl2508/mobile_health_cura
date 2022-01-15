import 'package:cura/model/general/room.dart';
import 'package:cura/screens/home_screen.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/globals.dart' as globals;

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({Key? key}) : super(key: key);

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<Room> rooms =
      globals.masterContext.getById(QueryWrapper.nursingHomeID)!.rooms;
  String? _roomName = '';
  int _roomNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cura_darkCyan,
          title: Text('New Room'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                      validator: (val) => val!.isEmpty ? 'Enter a Name' : null,
                      decoration: InputDecoration(
                          hintText: 'Name',
                          labelText: 'Room Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onChanged: (val) {
                        setState(() => _roomName = val);
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? 'Enter a Roomnumber' : null,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Number',
                          labelText: 'Room Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onChanged: (val) {
                        setState(() => _roomNumber = int.parse(val));
                      }),
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
                      if (_formKey.currentState!.validate()) {
                        Room newRoom = Room(
                            number: _roomNumber, name: _roomName, patients: []);
                        await QueryWrapper.postRoom(newRoom);
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
}
