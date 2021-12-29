// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wound_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WoundEntry _$WoundEntryFromJson(Map<String, dynamic> json) => WoundEntry(
      id: json['id'] as String,
      date: firestoreDateTimeFromJson(json['date']),
      size: (json['size'] as num).toDouble(),
      status: json['status'] as String,
      images: json['images'] == null
          ? []
          : (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$WoundEntryToJson(WoundEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': firestoreDateTimeToJson(instance.date),
      'size': instance.size,
      'status': instance.status,
      'images': instance.images,
    };
