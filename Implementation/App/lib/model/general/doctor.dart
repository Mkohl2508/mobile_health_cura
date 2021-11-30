import 'package:cura/model/general/person.dart';

class Doctor extends Person {
  final String degree;
  final String? type;

  Doctor(
      {required id,
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
}
