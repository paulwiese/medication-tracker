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
    Medication(id: 0, name: 'Vitamin A1', active: true, cycle: 7, last: DateTime(2024,11, 15), next: DateTime(2024, 11, 22), stock: 20, started: DateTime(2024,11, 14), total: 0),
    Medication(id: 1, name: 'Vitamin A2', active: true, cycle: 7, last: DateTime(2024,11, 15), next: DateTime(2024, 11, 22), stock: 20, started: DateTime(2024,11, 14), total: 0),
    Medication(id: 2, name: 'Vitamin A3', active: true, cycle: 7, last: DateTime(2024,11, 15), next: DateTime(2024, 11, 22), stock: 20, started: DateTime(2024,11, 14), total: 0),


    Medication(id: 3, name: 'Vitamin B1', active: true, cycle: 7, last: DateTime(2024,11, 16), next: DateTime(2024, 11, 23), stock: 20, started: DateTime(2024,11, 10), total: 0),
    Medication(id: 4, name: 'Vitamin B2', active: true, cycle: 7, last: DateTime(2024,11, 16), next: DateTime(2024, 11, 23), stock: 20, started: DateTime(2024,11, 10), total: 0),
    Medication(id: 5, name: 'Vitamin B3', active: true, cycle: 7, last: DateTime(2024,11, 16), next: DateTime(2024, 11, 23), stock: 20, started: DateTime(2024,11, 10), total: 0),

    Medication(id: 6, name: 'Vitamin C1', active: true, cycle: 7, last: DateTime(2024, 11, 14), next: DateTime(2024, 11, 21), stock: 20, started: DateTime(2024,11, 22), total: 0),
    Medication(id: 7, name: 'Vitamin C2', active: true, cycle: 7, last: DateTime(2024, 11, 14), next: DateTime(2024, 11, 21), stock: 20, started: DateTime(2024,11, 22), total: 0),
    Medication(id: 8, name: 'Vitamin C3', active: true, cycle: 7, last: DateTime(2024, 11, 14), next: DateTime(2024, 11, 21), stock: 20, started: DateTime(2024,11, 22), total: 0),
  ];

  box.put(0, medication);
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation()
    );
  }
}