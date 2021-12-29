import 'package:intl/intl.dart';

import 'package:json_annotation/json_annotation.dart';
part 'wound_entry.g.dart';

dynamic firestoreDateTimeToJson(dynamic value) => value;

DateTime firestoreDateTimeFromJson(dynamic value) {
  return value != null ? value.toDate() : value;
}

@JsonSerializable()
class WoundEntry {
  final String id;
  @JsonKey(
    toJson: firestoreDateTimeToJson,
    fromJson: firestoreDateTimeFromJson,
  )
  final DateTime date;
  final double size;
  final String status;
  final List<String> images;

  WoundEntry(
      {required this.id,
      required this.date,
      required this.size,
      required this.status,
      required this.images});

  String formattedDate() {
    return DateFormat('dd.MM.yyyy').format(date);
  }

  factory WoundEntry.fromJson(Map<String, dynamic> json) =>
      _$WoundEntryFromJson(json);

  Map<String, dynamic> toJson() => _$WoundEntryToJson(this);
}
