import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/residence/residence.dart';

class OldPeopleHome {
  final String id;
  final String name;
  final List<Room> rooms;
  final List<Nurse> nurses;
  final Residence residence;

  OldPeopleHome({
    required this.id,
    required this.name,
    required this.rooms,
    required this.nurses,
    required this.residence,
  });
}
