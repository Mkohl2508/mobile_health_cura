import 'package:cura/model/general/person.dart';
import 'package:json_annotation/json_annotation.dart';
part 'nurse.g.dart';

@JsonSerializable()
class Nurse extends Person {
  final String? role;

  Nurse(
      {id,
      required firstName,
      required surname,
      required birthDate,
      required residence,
      required phoneNumber,
      this.role})
      : super(
            id: id,
            firstName: firstName,
            surname: surname,
            birthDate: birthDate,
            residence: residence,
            phoneNumber: phoneNumber);

  factory Nurse.fromJson(Map<String, dynamic> json) => _$NurseFromJson(json);

  Map<String, dynamic> toJson() => _$NurseToJson(this);
}
