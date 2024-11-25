import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/index.dart';

import 'models/medication.dart';


void main() async {

  await Hive.initFlutter();

  Hive.registerAdapter(MedicationAdapter());

  await Hive.openBox('medication');

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  
  var box = Hive.box('medication');
  
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 14),
          bodyMedium: TextStyle(fontSize: 12),
          bodySmall: TextStyle(fontSize: 10),
          titleLarge: TextStyle(fontSize: 18),
          titleMedium: TextStyle(fontSize: 16),
          titleSmall: TextStyle(fontSize: 14),
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 11, 62, 140),
          onPrimary: Colors.white,
          secondary: Colors.black,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surface: Color.fromARGB(255, 250, 250, 252),
          onSurface: Colors.black,
        ),
        
      ),
      home: box.get(1) == 'ready' ? const Navigation() : const Start()
    );
  }
}