// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'residence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Residence _$ResidenceFromJson(Map<String, dynamic> json) => Residence(
      city: json['city'] as String,
      street: json['street'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$ResidenceToJson(Residence instance) => <String, dynamic>{
      'city': instance.city,
      'street': instance.street,
      'zipCode': instance.zipCode,
      'country': instance.country,
    };
