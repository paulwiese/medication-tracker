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

  @HiveField(9)
  String category;

  @HiveField(10)
  bool prescription;

  @HiveField(11)
  String info;

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
    required this.category,
    required this.prescription,
    required this.info
  });

  Medication clone() {
    return Medication(
      id: id,
      name: name,
      active: active,
      cycle: cycle,
      last: last,
      next: next,
      stock: stock,
      started: started,
      total: total,
      category: category,
      prescription: prescription,
      info: info,
    );
  }

}
