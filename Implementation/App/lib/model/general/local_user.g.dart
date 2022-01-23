// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) => LocalUser(
      name: json['name'] as String?,
      email: json['email'] as String,
      lastLogin: DateTime.parse(json['lastLogin'] as String),
      creationDate: DateTime.parse(json['creationDate'] as String),
      role: $enumDecode(_$RolesEnumMap, json['role']),
      buildNumber: json['buildNumber'] as int,
    );

Map<String, dynamic> _$LocalUserToJson(LocalUser instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'lastLogin': instance.lastLogin.toIso8601String(),
      'creationDate': instance.creationDate.toIso8601String(),
      'role': _$RolesEnumMap[instance.role],
      'buildNumber': instance.buildNumber,
    };

const _$RolesEnumMap = {
  Roles.admin: 'admin',
  Roles.nurse: 'nurse',
};
