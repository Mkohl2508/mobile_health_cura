import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/model/widget/BasicTile.dart';
import 'package:cura/shared/basic_tile_widget.dart';
import 'package:flutter/material.dart';

class PatienListScreen extends StatefulWidget {
  const PatienListScreen({Key? key}) : super(key: key);

  @override
  _PatienListScreenState createState() => _PatienListScreenState();
}

class _PatienListScreenState extends State<PatienListScreen> {
  final roomTiles = <BasicTile>[
    BasicTile(title: "Room 1", tiles: [
      BasicTile(title: "Ulrike Steinbock"),
      BasicTile(title: "Peter Lacher"),
    ]),
    BasicTile(title: "Room 2", tiles: [
      BasicTile(title: "Jürgen Wöniger"),
      BasicTile(title: "Hans Kurt"),
    ]),
    BasicTile(title: "Room 3", tiles: [
      BasicTile(title: "Beate Prüggel"),
      BasicTile(title: "Dieter Bolen"),
    ]),
    BasicTile(title: "Room 4", tiles: [
      BasicTile(title: "Beate Prüggel"),
      BasicTile(title: "Dieter Bolen"),
    ]),
    BasicTile(title: "Room 5", tiles: [
      BasicTile(title: "Beate Prüggel"),
      BasicTile(title: "Dieter Bolen"),
    ]),
    BasicTile(title: "Room 6", tiles: [
      BasicTile(title: "Beate Prüggel"),
      BasicTile(title: "Dieter Bolen"),
    ]),
    BasicTile(title: "Room 7", tiles: [
      BasicTile(title: "Beate Prüggel"),
      BasicTile(title: "Dieter Bolen"),
    ]),
  ];

  //final List<bool> _isExpanded; //= List.generate(numOfRooms, (_) => false);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.73,
        child: ListView(
          children:
              roomTiles.map((tile) => BasicTileWidget(tile: tile)).toList(),
        ));
  }
}
