import 'package:intl/intl.dart';

class WoundEntry {
  final String id;
  final DateTime date;
  final double size;
  final String status;
  final List<String> images;

  WoundEntry(
      {required this.id,
      required this.date,
      required this.size,
      required this.status,
      required this.images});

  String formattedDate() {
    return DateFormat('dd.MM.yyyy').format(date);
  }
}
