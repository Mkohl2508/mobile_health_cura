import 'package:cura/model/general/person.dart';

class Doctor extends Person {
  final String degree;
  final String? type;

  Doctor({id, name, birthDate, residence, this.type, required this.degree})
      : super(id: id, name: name, birthDate: birthDate, residence: residence);
}
