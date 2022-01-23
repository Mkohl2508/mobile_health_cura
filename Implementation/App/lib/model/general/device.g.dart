// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      deviceId: json['deviceId'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      updateDate: DateTime.parse(json['updateDate'] as String),
      uninstalled: json['uninstalled'] as bool,
      deviceData:
          DeviceData.fromJson(json['deviceData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'deviceId': instance.deviceId,
      'creationDate': instance.creationDate.toIso8601String(),
      'updateDate': instance.updateDate.toIso8601String(),
      'uninstalled': instance.uninstalled,
      'deviceData': instance.deviceData.toJson(),
    };
