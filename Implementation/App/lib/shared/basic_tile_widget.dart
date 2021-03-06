import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/model/widget/BasicTile.dart';
import 'package:cura/screens/patient_screen.dart';
import 'package:flutter/material.dart';

class BasicTileWidget extends StatelessWidget {
  final BasicTile tile;

  /// Standardized tile for reuse
  const BasicTileWidget({Key? key, required this.tile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = tile.title;
    final tiles = tile.tiles;
    final function = tile.function;
    final parent = tile.parent;

    if (tiles.isEmpty && parent != null) {
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
    } else if (tiles.isEmpty && parent == null) {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.cure_brightBlue,
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListTile(
          onTap: function,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: AppColors.cura_cyan,
          title: Padding(
            padding: const EdgeInsets.only(
              left: 25,
            ),
            child: Text(
              title,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.cure_brightBlue,
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ExpansionTile(
          iconColor: AppColors.cura_cyan,
          textColor: AppColors.cura_cyan,
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
