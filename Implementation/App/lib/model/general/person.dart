import 'package:cura/model/residence/residence.dart';
import 'package:intl/intl.dart';

class Person {
  final String id;
  final String firstName;
  final String surname;
  final DateTime birthDate;
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
}
