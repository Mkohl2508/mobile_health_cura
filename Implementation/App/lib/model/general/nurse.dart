import 'package:cura/model/general/person.dart';

class Nurse extends Person {
  final String? role;

  Nurse({id, name, birthDate, residence, this.role})
      : super(id: id, name: name, birthDate: birthDate, residence: residence);
}
