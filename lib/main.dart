import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/index.dart';

import 'models/medication.dart';


void main() async {

  await Hive.initFlutter();

  Hive.registerAdapter(MedicationAdapter());

  var box = await Hive.openBox('medication');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var box = Hive.box('medication');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: box.get(1) == 'ready' ? const Navigation() : const Start()
    );
  }
}