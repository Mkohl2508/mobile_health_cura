import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/model/widget/BasicTile.dart';
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

class BasicTileWidget extends StatelessWidget {
  final BasicTile tile;

  const BasicTileWidget({Key? key, required this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = tile.title;
    final tiles = tile.tiles;

    if (tiles.isEmpty) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: Colors.white,
          title: Text(title),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 35, right: 35, top: 25),
        child: ExpansionTile(
          collapsedIconColor: AppColors.cura_brown,
          iconColor: AppColors.cura_orange,
          collapsedTextColor: AppColors.cura_brown,
          textColor: AppColors.cura_orange,
          title: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          children: tiles.map((tile) => BasicTileWidget(tile: tile)).toList(),
        ),
      );
    }
  }
}
