import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/model/widget/BasicTile.dart';
import 'package:cura/screens/patient_screen.dart';
import 'package:cura/shared/basic_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:cura/globals.dart' as globals;
import 'package:cloud_firestore/cloud_firestore.dart';

class PatienListScreen extends StatefulWidget {
  const PatienListScreen({Key? key}) : super(key: key);

  @override
  _PatienListScreenState createState() => _PatienListScreenState();
}

class _PatienListScreenState extends State<PatienListScreen> {
  List<BasicTile> _initTiles(Map<String, dynamic> data) {
    final roomTiles = <BasicTile>[];
    for (var room in globals.masterContext.getById("1oldPeopleHome")!.rooms) {
      final patientTiles = <BasicTile>[];
      for (var patient in room.patients) {
        patientTiles.add(BasicTile(
            title: patient.fullName(),
            function: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientScreen(
                            patient: patient,
                          )));
            }));
      }

      BasicTile roomTile = BasicTile(
          title: "Room " + room.number.toString(), tiles: patientTiles);
      roomTiles.add(roomTile);
    }
    return roomTiles;
  }

  //final List<bool> _isExpanded; //= List.generate(numOfRooms, (_) => false);

  @override
  Widget build(BuildContext context) {
    CollectionReference home =
        FirebaseFirestore.instance.collection('NursingHome');

    return FutureBuilder<DocumentSnapshot>(
      future: home.doc("Uoto3xaa5ZL9N2mMjPhG").get(),
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
          return Container(
              height: MediaQuery.of(context).size.height * 0.73,
              child: ListView(
                children: _initTiles(data)
                    .map((tile) => BasicTileWidget(tile: tile))
                    .toList(),
              ));
        }

        return Text("loading");
      },
    );
  }
}
