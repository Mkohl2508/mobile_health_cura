import 'package:cura/model/general/person.dart';
import 'package:json_annotation/json_annotation.dart';
part 'doctor.g.dart';

@JsonSerializable(explicitToJson: true)
class Doctor extends Person {
  final String degree;
  final String? type;

  Doctor(
      {id,
      required firstName,
      required birthDate,
      required residence,
      required surname,
      required phoneNumber,
      this.type,
      required this.degree})
      : super(
            id: id,
            firstName: firstName,
            birthDate: birthDate,
            residence: residence,
            surname: surname,
            phoneNumber: phoneNumber);

  @override
  String fullName() {
    return degree + " " + firstName + " " + surname;
  }

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
