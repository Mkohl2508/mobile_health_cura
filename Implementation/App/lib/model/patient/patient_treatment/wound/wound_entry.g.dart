// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wound_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WoundEntry _$WoundEntryFromJson(Map<String, dynamic> json) => WoundEntry(
      id: json['id'] as String?,
      date: firestoreDateTimeFromJson(json['date']),
      size: (json['size'] as num).toDouble(),
      status: json['status'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      isOpen: json['isOpen'] as bool?,
      phase: $enumDecodeNullable(_$PhaseEnumEnumMap, json['phase']),
      length: (json['length'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      depth: (json['depth'] as num?)?.toDouble(),
      painLevel: json['painLevel'] as int?,
      edge: $enumDecodeNullable(_$EdgeEnumEnumMap, json['edge']),
      isSmelly: json['isSmelly'] as bool?,
      exudate: $enumDecodeNullable(_$ExudateEnumEnumMap, json['exudate']),
    );

Map<String, dynamic> _$WoundEntryToJson(WoundEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': firestoreDateTimeToJson(instance.date),
      'size': instance.size,
      'status': instance.status,
      'images': instance.images,
      'isOpen': instance.isOpen,
      'phase': _$PhaseEnumEnumMap[instance.phase],
      'length': instance.length,
      'width': instance.width,
      'depth': instance.depth,
      'painLevel': instance.painLevel,
      'edge': _$EdgeEnumEnumMap[instance.edge],
      'isSmelly': instance.isSmelly,
      'exudate': _$ExudateEnumEnumMap[instance.exudate],
    };

const _$PhaseEnumEnumMap = {
  PhaseEnum.hemostasis: 'hemostasis',
  PhaseEnum.inflammatory: 'inflammatory',
  PhaseEnum.proliferative: 'proliferative',
  PhaseEnum.maturation: 'maturation',
};

const _$EdgeEnumEnumMap = {
  EdgeEnum.diffuse: 'diffuse',
  EdgeEnum.defined: 'defined',
  EdgeEnum.rolled: 'rolled',
  EdgeEnum.undefined: 'undefined',
};

const _$ExudateEnumEnumMap = {
  ExudateEnum.serous: 'serous',
  ExudateEnum.sanguineous: 'sanguineous',
  ExudateEnum.serosanguinous: 'serosanguinous',
  ExudateEnum.purulent: 'purulent',
  ExudateEnum.undefined: 'undefined',
};
