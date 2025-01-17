import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'index.dart';

class Experiment extends StatefulWidget {
  const Experiment({super.key});
  @override
  State<Experiment> createState() => _ExperimentState();
}

class _ExperimentState extends State<Experiment> {
  late final Box box;
  late bool vb;

  @override
  void initState() {
    super.initState();
    box = Hive.box('medication');
    vb = box.get(6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Experiment'),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(keys: [8]),
        builder: (context, Box box, _) {
          List<bool> completed =
              box.get(8, defaultValue: List<bool>.filled(6, false));

          int completedA = completed
              .asMap()
              .entries
              .where((entry) => entry.key % 2 == 0 && entry.value)
              .length;

          int completedB = completed
              .asMap()
              .entries
              .where((entry) => entry.key % 2 == 1 && entry.value)
              .length;

          int c = vb ? completedB : completedA;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please complete all tasks using Browse-Page ${vb ? 'Version-B:\nCategory Tiles + Swipe View' : 'Version-A:\nAlphabetical List + Category Filters'}',
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      '$c/4 tasks completed',
                      style: TextStyle(
                          color: c == 4 ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 20),
                vb ? const Task(t: 1) : const Task(t: 0),
                const SizedBox(height: 20),
                vb ? const Task(t: 3) : const Task(t: 2),
                const SizedBox(height: 20),
                vb ? const Task(t: 5) : const Task(t: 4),
                const SizedBox(height: 20),
                vb ? const Task(t: 7) : const Task(t: 6),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

}
