import 'package:cura/model/residence/residence.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'person.g.dart';

dynamic firestoreDateTimeToJson(dynamic value) => value;

DateTime firestoreDateTimeFromJson(dynamic value) {
  return value != null ? value.toDate() : value;
}

Residence firestoreResidenceFromJson(dynamic value) {
  return value != null ? Residence.fromJson(value) : value;
}

@JsonSerializable(explicitToJson: true)
class Person {
  final String id;
  final String firstName;
  final String surname;

  @JsonKey(
    toJson: firestoreDateTimeToJson,
    fromJson: firestoreDateTimeFromJson,
  )
  final DateTime birthDate;
  @JsonKey(fromJson: firestoreResidenceFromJson)
  final Residence residence;
  final String? phoneNumber;

  Person(
      {required this.id,
      required this.firstName,
      required this.surname,
      required this.birthDate,
      required this.residence,
      this.phoneNumber});

  String fullName() {
    return firstName + " " + surname;
  }

  String formattedBirthday() {
    return DateFormat('dd.MM.yyyy').format(birthDate);
  }

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
