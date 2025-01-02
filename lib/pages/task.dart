import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medication_tracker/models/medication.dart';
import 'index.dart';

class Task extends StatefulWidget {
  final int t;

  const Task({super.key, required this.t});
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late final Box box;
  late int t;

  late List<bool> completed;
  late List<bool> running;
  late List<double> result;

  late bool free;

  late DateTime start = DateTime.now();
  late DateTime end = DateTime.now();

  List<String> tasks = [
    'Task 1: Find out if the Skin Treatment "Clindamycin Gel" requires a prescription',
    'Task 2: Find a supplement that may help you with muscle relaxation.',
    'Task 3: A 55-year-old individual with a history of stomach ulcers has developed a mild headache. They need a pain reliever but must avoid any medication that could worsen their stomach condition. The individual prefers a prescription option. Please help to find a suitable medication.',
    'Task 4: Look for an over the counter mental health medication (no prescription required).',
    'Task 5: Find a medicatin that provides nighttime relief from cold and flu symptoms.',
  ];

  @override
  void initState() {
    super.initState();
    box = Hive.box('medication'); // Open the Hive box

    t = widget.t;

    update();
  }

  update() {
    setState(() {
      completed = box.get(8);
      running = box.get(9);
      result = box.get(10);
      free = box.get(11);
      start = box.get(12);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 90,
              decoration: BoxDecoration(
                  color: Colors.blue[100],
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0))),
              child: TextButton(
                onPressed: () {
                  update();
                  if ((running[t] | free) && !completed[t]) {
                    setState(() {
                      running[t] = !running[t];
                      if (!running[t]) {
                        completed[t] = true;
                        result[t] = 1.0;
                        free = true;
                        end = DateTime.now();
                        result[t] =
                            end.difference(start).inMilliseconds * 0.001;
                      } else {
                        start = DateTime.now();
                        free = false;
                        completed[t] = false;
                      }
                      box.put(8, completed);
                      box.put(9, running);
                      box.put(10, result);
                      box.put(11, free);
                      box.put(12, start);
                    });
                  }
                },
                child: !running[t]
                    ? Text('Start T${t + 1}',
                        style: const TextStyle(color: Colors.black))
                    : Text('Finish T${t + 1}',
                        style: const TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: running[t]
                  ? const Text(
                      'running',
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    )
                  : (completed[t]
                      ? Text('completed in ${result[t].toStringAsFixed(3)}s',
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green))
                      : const Text('To-Do',
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange))),
            ),
            const SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirm Task Reset'),
                        content: const Text(
                            'Are you sure you want to reset this task? You will have to do it again.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                running[t] = false;
                                completed[t] = false;
                                box.put(8, completed);
                                box.put(9, running);
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Reset'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        (running[t] | completed[t])
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  tasks[t],
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 12),
                ),
              )
            : const SizedBox(
                height: 0,
              ),
      ],
    ));
  }
}
