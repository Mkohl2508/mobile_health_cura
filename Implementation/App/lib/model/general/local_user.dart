import 'package:cura/model/enums/roles.dart';
import 'package:cura/model/general/device.dart';
import 'package:json_annotation/json_annotation.dart';
part 'local_user.g.dart';

@JsonSerializable(explicitToJson: true)
class LocalUser {
  final String? name;
  final String email;
  final DateTime lastLogin;
  final DateTime creationDate;
  final Roles role;
  final int buildNumber;
  @JsonKey(ignore: true)
  String? profileImage;
  @JsonKey(ignore: true)
  Device? device;

  LocalUser(
      {required this.name,
      required this.email,
      required this.lastLogin,
      required this.creationDate,
      required this.role,
      required this.buildNumber,
      this.profileImage,
      this.device});

  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      _$LocalUserFromJson(json);

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}
