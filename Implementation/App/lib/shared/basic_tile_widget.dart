import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/model/widget/BasicTile.dart';
import 'package:cura/screens/patient_screen.dart';
import 'package:flutter/material.dart';

class BasicTileWidget extends StatelessWidget {
  final BasicTile tile;

  const BasicTileWidget({Key? key, required this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = tile.title;
    final tiles = tile.tiles;
    final function = tile.function;

    if (tiles.isEmpty) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          onTap: function,
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
