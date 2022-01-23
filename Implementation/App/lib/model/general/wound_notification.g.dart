// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wound_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WoundNotification _$WoundNotificationFromJson(Map<String, dynamic> json) =>
    WoundNotification(
      id: json['id'] as String,
      woundId: json['woundId'] as String,
      patientId: json['patientId'] as String,
      status: $enumDecode(_$NotificationStatusEnumMap, json['status']),
      timeStamp: firestoreDateTimeFromJson(json['timeStamp']),
      roomId: json['roomId'] as int,
      description: json['description'] as String?,
      nurseId: json['nurseId'] as String?,
    );

Map<String, dynamic> _$WoundNotificationToJson(WoundNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'woundId': instance.woundId,
      'patientId': instance.patientId,
      'nurseId': instance.nurseId,
      'status': _$NotificationStatusEnumMap[instance.status],
      'timeStamp': firestoreDateTimeToJson(instance.timeStamp),
      'description': instance.description,
      'roomId': instance.roomId,
    };

const _$NotificationStatusEnumMap = {
  NotificationStatus.toDo: 'To do',
  NotificationStatus.inProgress: 'In Progress',
  NotificationStatus.done: 'Done',
};
