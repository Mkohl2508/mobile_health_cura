import 'package:cura/model/general/doctor.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/general/wound_notification.dart';
import 'package:cura/model/residence/residence.dart';
import 'package:json_annotation/json_annotation.dart';
part 'old_people_home.g.dart';

@JsonSerializable(explicitToJson: true)
class OldPeopleHome {
  static List<Room> emptyRooms(dynamic value) => <Room>[];
  static List<Nurse> emptyNurses(_) => <Nurse>[];
  static List<Doctor> emptyDoctors(_) => <Doctor>[];
  static List<WoundNotification> emptyNotifications(_) => <WoundNotification>[];

  final String id;
  final String name;
  @JsonKey(fromJson: emptyRooms, includeIfNull: false)
  final List<Room> rooms;
  @JsonKey(fromJson: emptyNurses, includeIfNull: false)
  final List<Nurse> nurses;
  final Residence residence;
  @JsonKey(fromJson: emptyDoctors, includeIfNull: false)
  final List<Doctor> doctors;
  @JsonKey(fromJson: emptyNotifications, includeIfNull: false)
  List<WoundNotification> notifications;

  OldPeopleHome(
      {required this.id,
      required this.name,
      required this.rooms,
      required this.nurses,
      required this.residence,
      required this.doctors,
      required this.notifications});

  factory OldPeopleHome.fromJson(Map<String, dynamic> json) =>
      _$OldPeopleHomeFromJson(json);

  Map<String, dynamic> toJson() => _$OldPeopleHomeToJson(this);

  Room? getRoomById(int id) {
    return rooms.firstWhere((room) => room.number == id);
  }

  Nurse? getNurseById(String id) {
    try {
      return nurses.firstWhere((nurse) => nurse.id == id,
          orElse: () => throw Exception('Nurse not found'));
    } catch (e) {
      return null;
    }
  }
}
