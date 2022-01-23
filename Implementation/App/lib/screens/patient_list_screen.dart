import 'package:cura/model/widget/BasicTile.dart';
import 'package:cura/screens/patient_screen.dart';
import 'package:cura/shared/basic_tile_widget.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:cura/globals.dart' as globals;

class PatienListScreen extends StatefulWidget {
  /// This Screen displays an overview of all rooms with the individual patients
  const PatienListScreen({Key? key}) : super(key: key);

  @override
  _PatienListScreenState createState() => _PatienListScreenState();
}

class _PatienListScreenState extends State<PatienListScreen> {
  List<BasicTile> _initTiles() {
    final roomTiles = <BasicTile>[];
    for (var room
        in globals.masterContext.getById(QueryWrapper.nursingHomeID)!.rooms) {
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
                            room: room,
                          )));
            },
            parent: 'there is one'));
      }

      BasicTile roomTile = BasicTile(
          parent: null,
          title: "Room " + room.number.toString(),
          tiles: patientTiles);
      roomTiles.add(roomTile);
    }
    return roomTiles;
  }

  //final List<bool> _isExpanded; //= List.generate(numOfRooms, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.74,
        child: ListView(
          children:
              _initTiles().map((tile) => BasicTileWidget(tile: tile)).toList(),
        ));
  }
}
