import 'package:cura/model/enums/notification_status_enum.dart';
import 'package:cura/model/general/nurse.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wound_notification.g.dart';

@JsonSerializable()
class WoundNotification {
  final String id;
  final String woundId;
  final String patientId;
  String? nurseId;
  NotificationStatus status;
  @JsonKey(
    toJson: firestoreDateTimeToJson,
    fromJson: firestoreDateTimeFromJson,
  )
  final DateTime timeStamp;
  final String? description;
  final int roomId;

  WoundNotification({
    required this.id,
    required this.woundId,
    required this.patientId,
    required this.status,
    required this.timeStamp,
    required this.roomId,
    this.description,
    this.nurseId,
  });

  factory WoundNotification.fromJson(Map<String, dynamic> json) =>
      _$WoundNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$WoundNotificationToJson(this);
}
