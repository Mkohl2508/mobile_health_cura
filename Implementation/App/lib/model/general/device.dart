import 'package:cura/model/general/device_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device.g.dart';

@JsonSerializable(explicitToJson: true)
class Device {
  final String deviceId;
  final DateTime creationDate;
  final DateTime updateDate;
  final bool uninstalled;
  final DeviceData deviceData;

  Device(
      {required this.deviceId,
      required this.creationDate,
      required this.updateDate,
      required this.uninstalled,
      required this.deviceData});

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
