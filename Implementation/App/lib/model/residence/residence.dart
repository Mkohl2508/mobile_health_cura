import 'package:json_annotation/json_annotation.dart';
part 'residence.g.dart';

@JsonSerializable()
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

  factory Residence.fromJson(Map<String, dynamic> json) =>
      _$ResidenceFromJson(json);

  Map<String, dynamic> toJson() => _$ResidenceToJson(this);
}
