import 'package:cura/model/residence/residence.dart';

class Person {
  final String id;
  final String name;
  final DateTime birthDate;
  final Residence residence;

  Person({
    required this.id,
    required this.name,
    required this.birthDate,
    required this.residence,
  });
}
