import 'package:json_annotation/json_annotation.dart';
part 'device_data.g.dart';

@JsonSerializable(explicitToJson: true)
class DeviceData {

  final String osVersion;
  final String? platform;
  final String model;
  final String device;

  DeviceData({required this.osVersion, this.platform, required this.model, required this.device});

  factory DeviceData.fromJson(Map<String, dynamic> json) => _$DeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceDataToJson(this);
}
