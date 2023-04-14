
import 'package:iasd_myadmin/app/core/departament/model/departaments.dart';

class Activity {
  String id;
  final List<Departaments> departaments;
  String name;
  DateTime date;

  Activity({
    required this.id,
    required this.departaments,
    required this.name,
    required this.date,
  });
}
