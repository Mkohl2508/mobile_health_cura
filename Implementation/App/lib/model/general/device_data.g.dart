// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceData _$DeviceDataFromJson(Map<String, dynamic> json) => DeviceData(
      osVersion: json['osVersion'] as String,
      platform: json['platform'] as String?,
      model: json['model'] as String,
      device: json['device'] as String,
    );

Map<String, dynamic> _$DeviceDataToJson(DeviceData instance) =>
    <String, dynamic>{
      'osVersion': instance.osVersion,
      'platform': instance.platform,
      'model': instance.model,
      'device': instance.device,
    };
