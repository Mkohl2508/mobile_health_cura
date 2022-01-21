import 'package:cura/model/general/person.dart';
import 'package:json_annotation/json_annotation.dart';
part 'nurse.g.dart';

@JsonSerializable(createToJson: false)
class Nurse extends Person {
  final String userId;

  Nurse(
      {id,
      firstName,
      surname,
      birthDate,
      residence,
      phoneNumber,
      required this.userId})
      : super(
            id: id,
            firstName: firstName,
            surname: surname,
            birthDate: birthDate,
            residence: residence,
            phoneNumber: phoneNumber);

  factory Nurse.fromJson(Map<String, dynamic> json) => _$NurseFromJson(json);

  Map<String, dynamic> toJson() =>  <String, dynamic>{
      'id': id
    };
}
