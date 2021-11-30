import 'package:cura/model/general/person.dart';

class Nurse extends Person {
  final String? role;

  Nurse(
      {required id,
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
}
