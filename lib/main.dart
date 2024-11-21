import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/index.dart';

import 'models/medication.dart';


void main() async {

  await Hive.initFlutter();

  await Hive.deleteBoxFromDisk('medication');

  Hive.registerAdapter(MedicationAdapter());

  var box = await Hive.openBox('medication');

  var medication = [
    Medication(id: 0, name: 'Vitamin A', active: true, cycle: 7, last: DateTime(2024,11, 14), next: DateTime(2024, 11, 21), stock: 20),
    Medication(id: 1, name: 'Vitamin B', active: true, cycle: 7, last: DateTime(2024,11, 10), next: DateTime(2024, 11, 17), stock: 20),
    Medication(id: 2, name: 'Vitamin C', active: true, cycle: 7, last: DateTime(2024, 11, 22), next: DateTime(2024, 11, 29), stock: 20),
  ];

  box.put(0, medication);
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Navigation()
    );
  }
}