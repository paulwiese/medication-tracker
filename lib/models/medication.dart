import 'package:hive/hive.dart';

part 'medication.g.dart';

@HiveType(typeId: 0)
class Medication extends HiveObject {
  
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool active;

  @HiveField(3)
  int cycle;

  @HiveField(4)
  DateTime last;

  @HiveField(5)
  DateTime next;

  @HiveField(6)
  int stock;

  @HiveField(7)
  DateTime started;

  @HiveField(8)
  int total;

  Medication({
    required this.id,
    required this.name,
    required this.active,
    required this.cycle,
    required this.last,
    required this.next,
    required this.stock,
    required this.started,
    required this.total,
  });

}
