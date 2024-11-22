import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'index.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});
  
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  
  var box = Hive.box('medication');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: 
        TextButton(onPressed: () {
          box.put(1,'not-ready');
          Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Start(),
                      ),
                    );
        },
        child: const Text('Reset'))
      )
    );
  }
}