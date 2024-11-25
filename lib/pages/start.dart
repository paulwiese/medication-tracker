import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medication_tracker/models/medication.dart';
import 'index.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  var box = Hive.box('medication');

  final TextEditingController _name = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 120,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                        labelText: 'Hi there, what\'s your name?'),
                  )),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.blue[100], 
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(Radius.circular(12.0))
                        ),
                      child: TextButton(
                          onPressed: () {
                            String input = _name.text;
                            setState(() {
                              if (input.isNotEmpty) {
                                box.put(2, input);
                                List<Medication> m = [];
                                box.put(0, m);
                                box.put(1, 'ready');
                                box.put(3, false);
                              } else {
                                box.put(1, 'not-ready');
                              }
                            });
                          },
                          child: const Text('Confirm', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ))),
                ],
              ),
              const Text(
                '(Enter your name and confirm)',
                style: TextStyle(fontSize: 12.0),
              ),
              const SizedBox(
                height: 40,
              ),
              (box.get(1) == 'ready')
                  ? Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[100], 
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(Radius.circular(12.0))
                          ),
                          child: TextButton(
                            onPressed: () {
                              box.put(3, false);
                              box.put(4, true);
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => const Navigation(),
                              ),);
                            }
                            , child: const Text('Start fresh', style: TextStyle(color: Colors.black))
                          )
                        ),
                        const SizedBox(width: 20,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[100], 
                            shape: BoxShape.rectangle,
                            borderRadius: const BorderRadius.all(Radius.circular(12.0))
                          ),
                          child: TextButton(
                            onPressed: () {
                              DateTime now = DateTime.now();
                              DateTime today = DateTime(now.year, now.month, now.day);

                              Duration w = const Duration(days: 7);

                              List<DateTime> past = [];
                              List<DateTime> future = [];

                              for(int i = 0; i < 40; i++) {
                                past.add(today.subtract(Duration(days: i)));
                              }

                              for(int i = 0; i < 7; i++) {
                                future.add(today.add(Duration(days: i)));
                              }

                              List<Medication> medication = [
                                Medication(id: 0, name: 'Vitamin A', active: true, cycle: 7, last: past[20], next: past[13], stock: 9, started: past[30], total: 1),
                                Medication(id: 1, name: 'Vitamin B', active: false, cycle: 7, last: past[18], next: past[11], stock: 0, started: past[30], total: 2),
                                Medication(id: 2, name: 'Vitamin C', active: true, cycle: 7, last: past[17], next: past[10], stock: 4, started: past[30], total: 3),
                                Medication(id: 3, name: 'Vitamin D', active: true, cycle: 7, last: past[10], next: past[3], stock: 24, started: past[30], total: 4),
                                Medication(id: 4, name: 'Vitamin E', active: false, cycle: 7, last: past[8], next: past[1], stock: 2, started: past[30], total: 3),
                                Medication(id: 5, name: 'Vitamin F', active: true, cycle: 7, last: past[7], next: past[0], stock: 14, started: past[30], total: 2),
                                
                                Medication(id: 6, name: 'Vitamin G', active: true, cycle: 7, last: past[7], next: past[0], stock: 4, started: past[30], total: 4),
                                Medication(id: 7, name: 'Vitamin H', active: true, cycle: 7, last: past[7], next: past[0], stock: 18, started: past[30], total: 5),
                                Medication(id: 8, name: 'Vitamin I', active: true, cycle: 7, last: past[7], next: past[0], stock: 17, started: past[30], total: 5),
                                Medication(id: 9, name: 'Vitamin J', active: false, cycle: 7, last: past[7], next: past[0], stock: 19, started: past[30], total: 4),
                                Medication(id: 10, name: 'Vitamin K', active: true, cycle: 7, last: past[7], next: past[0], stock: 6, started: past[30], total: 3),
                                Medication(id: 11, name: 'Vitamin L', active: false, cycle: 7, last: past[7], next: past[0], stock: 11, started: past[30], total: 3),

                                Medication(id: 12, name: 'Vitamin M', active: false, cycle: 7, last: past[6], next: future[1], stock: 34, started: past[30], total: 4),
                                Medication(id: 13, name: 'Vitamin N', active: true, cycle: 7, last: past[4], next: future[3], stock: 7, started: past[30], total: 4),
                                Medication(id: 14, name: 'Vitamin O', active: true, cycle: 7, last: past[3], next: future[4], stock: 12, started: past[30], total: 4),
                                Medication(id: 15, name: 'Vitamin P', active: true, cycle: 7, last: past[2], next: future[5], stock: 3, started: past[30], total: 5),
                                Medication(id: 16, name: 'Vitamin Q', active: false, cycle: 7, last: past[1], next: future[6], stock: 0, started: past[30], total: 6),

                              ];
                              setState(() {
                                box.put(0, medication);
                                box.put(3, false);
                                box.put(4, true);
                              });
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => const Navigation(),
                              ),);
                            }
                            , child: const Text('Test with sample data', style: TextStyle(color: Colors.black))
                          )
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ],
          )),
    ));
  }
}
