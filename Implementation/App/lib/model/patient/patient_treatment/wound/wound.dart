class Wound {
  final String id;
  final String location;
  final String type;
  final bool isHealed;
  final DateTime startDate;

  Wound({
    required this.id,
    required this.location,
    required this.type,
    required this.isHealed,
    required this.startDate,
  });
}
