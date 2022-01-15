import 'package:cura/model/enums/edge_enum.dart';
import 'package:cura/model/enums/exudate_enum.dart';
import 'package:cura/model/enums/phase_enum.dart';
import 'package:intl/intl.dart';

import 'package:json_annotation/json_annotation.dart';
part 'wound_entry.g.dart';

dynamic firestoreDateTimeToJson(dynamic value) => value;

DateTime firestoreDateTimeFromJson(dynamic value) {
  return value != null ? value.toDate() : value;
}

@JsonSerializable()
class WoundEntry {
  String? id;
  @JsonKey(
    toJson: firestoreDateTimeToJson,
    fromJson: firestoreDateTimeFromJson,
  )
  final DateTime date;
  final List<String> images;
  final bool? isOpen;
  final PhaseEnum? phase;
  final double? length;
  final double? width;
  final double? depth;
  final int? painLevel;
  final EdgeEnum? edge;
  final bool? isSmelly;
  final ExudateEnum? exudate;

  WoundEntry(
      {this.id,
      required this.date,
      required this.images,
      this.isOpen,
      this.phase,
      this.length,
      this.width,
      this.depth,
      this.painLevel,
      this.edge,
      this.isSmelly,
      this.exudate});

  String formattedDate() {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  factory WoundEntry.fromJson(Map<String, dynamic> json) =>
      _$WoundEntryFromJson(json);

  Map<String, dynamic> toJson() => _$WoundEntryToJson(this);

  void add(String s) {
    images.add(s);
  }
}
