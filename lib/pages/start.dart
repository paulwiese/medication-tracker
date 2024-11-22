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

  TextEditingController _name = TextEditingController(text: '');

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
              SizedBox(height: 120,),
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
                          color: Colors.green[100], 
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
                              } else {
                                box.put(1, 'not-ready');
                              }
                            });
                          },
                          child: const Text('Confirm', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          //icon: const Icon(
                            //Icons.keyboard_return_rounded,
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
                              List<Medication> medication = [
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
                              setState(() {
                                box.put(0, medication);
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
