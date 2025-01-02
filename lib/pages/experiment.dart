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

  @override
  void initState() {
    super.initState();
    box = Hive.box('medication');
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
              box.get(8, defaultValue: List<bool>.filled(5, false));
          int completedCount = completed.where((task) => task).length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$completedCount/${completed.length} tasks completed',
                      style: TextStyle(
                          color: completedCount == completed.length
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const SizedBox(width: 10),
                    Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: completedCount == completed.length
                              ? Colors.green[100]
                              : Colors.grey[350],
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0))),
                        child: TextButton(
                            onPressed: () {if(completedCount == completed.length) {_showLogViewer();}},
                            child: const Padding(padding: EdgeInsets.all(5), child: Text(
                              'Export',
                              style: TextStyle(color: Colors.black),
                            ))),)
                  ],
                ),
                const SizedBox(height: 20),
                const Task(t: 0),
                const SizedBox(height: 20),
                const Task(t: 1),
                const SizedBox(height: 20),
                const Task(t: 2),
                const SizedBox(height: 20),
                const Task(t: 3),
                const SizedBox(height: 20),
                const Task(t: 4),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showLogViewer() {
    String logText = '${box.get(2)}\n${box.get(6) ? 'Version-B' : 'Version-A'}';

    List<double> result = box.get(10);

    for(int i = 0; i < result.length; i++) {
      logText += '\n${result[i].toStringAsFixed(3)}';
    }
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Experiment Log'),
          content: SingleChildScrollView(
            child: Text(
              logText,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: logText));
              },
              child: const Text('Copy to Clipboard'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
