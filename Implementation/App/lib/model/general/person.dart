import 'package:cura/model/residence/residence.dart';

class Person {
  final String id;
  final String firstName;
  final String surname;
  final DateTime birthDate;
  final Residence residence;

  Person({
    required this.id,
    required this.firstName,
    required this.surname,
    required this.birthDate,
    required this.residence,
  });
}
