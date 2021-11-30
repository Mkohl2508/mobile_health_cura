// ignore_for_file: file_names

class Residence {
  final String id;
  final String city;
  final String street;
  final String zipCode;
  final String country;

  Residence(
      {required this.id,
      required this.city,
      required this.street,
      required this.zipCode,
      required this.country});

  String getAddress() {
    return "$street, $zipCode $city";
  }
}
