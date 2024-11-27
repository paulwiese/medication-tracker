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
                        Flexible(child:
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
                        ),
                        const SizedBox(width: 20,),
                        Flexible(child:
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

                              for(int i = 0; i < 400; i++) {
                                past.add(today.subtract(Duration(days: i)));
                              }

                              for(int i = 0; i < 100; i++) {
                                future.add(today.add(Duration(days: i)));
                              }


                              /*
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
                              */

                              List<Medication> medication = [
                                Medication(id: 0, name: 'Vitamin A 5000 IU', active: true, cycle: 7, last: past[2], next: future[5], stock: 12, started: past[30], total: 3),
                                Medication(id: 1, name: 'Vitamin B 100mg', active: false, cycle: 7, last: past[3], next: future[4], stock: 7, started: past[25], total: 3),
                                Medication(id: 2, name: 'Vitamin C 500mg', active: true, cycle: 7, last: past[7], next: future[0], stock: 15, started: past[40], total: 5),
                                Medication(id: 0, name: 'Vitamin D 1000 IU', active: true, cycle: 7, last: past[8], next: past[1], stock: 12, started: past[30], total: 3),
                                Medication(id: 3, name: 'Paracetamol 500mg', active: true, cycle: 1, last: past[1], next: today, stock: 24, started: past[10], total: 6),
                                Medication(id: 4, name: 'Ibuprofen 400mg', active: true, cycle: 2, last: past[5], next: past[3], stock: 12, started: past[20], total: 8),
                                Medication(id: 5, name: 'Iron 65mg', active: true, cycle: 14, last: past[11], next: future[3], stock: 17, started: past[50], total: 3),
                                Medication(id: 6, name: 'Calcium 500mg', active: true, cycle: 7, last: past[3], next: future[4], stock: 17, started: past[30], total: 3),
                                Medication(id: 7, name: 'Zinc 50mg', active: false, cycle: 7, last: past[8], next: past[1], stock: 13, started: past[20], total: 2),
                                Medication(id: 8, name: 'Magnesium 400mg', active: true, cycle: 7, last: past[1], next: future[6], stock: 25, started: past[45], total: 5),
                                Medication(id: 9, name: 'Omega-3 1000mg', active: true, cycle: 1, last: today, next: future[1], stock: 26, started: past[100], total: 74),
                                Medication(id: 10, name: 'Probiotic', active: true, cycle: 30, last: past[25], next: future[5], stock: 8, started: past[120], total: 3),
                                Medication(id: 11, name: 'Aspirin 81mg', active: false, cycle: 1, last: past[1], next: today, stock: 32, started: past[200], total: 173),
                                Medication(id: 12, name: 'Metformin 500mg', active: true, cycle: 1, last: past[0], next: future[0], stock: 9, started: past[180], total: 132),
                                Medication(id: 13, name: 'Atorvastatin 20mg', active: true, cycle: 1, last: past[1], next: today, stock: 16, started: past[365], total: 301),
                                Medication(id: 14, name: 'Folic Acid 5mg', active: true, cycle: 7, last: past[6], next: future[1], stock: 12, started: past[60], total: 8),
                                Medication(id: 15, name: 'Vitamin D 1000 IU', active: true, cycle: 7, last: past[7], next: today, stock: 1, started: past[90], total: 11),
                                Medication(id: 16, name: 'Lisinopril 10mg', active: true, cycle: 1, last: past[1], next: today, stock: 11, started: past[120], total: 89),
                                Medication(id: 17, name: 'Albuterol 90mcg', active: false, cycle: 1, last: past[1], next: today, stock: 16, started: past[180], total: 113),
                                Medication(id: 18, name: 'Cetirizine 10mg', active: true, cycle: 1, last: past[3], next: past[2], stock: 23, started: past[50], total: 42),
                                Medication(id: 19, name: 'Prednisone 10mg', active: false, cycle: 1, last: past[1], next: today, stock: 29, started: past[30], total: 21),
                                Medication(id: 20, name: 'Amlodipine 5mg', active: false, cycle: 1, last: past[2], next: past[1], stock: 14, started: past[90], total: 75),
                                Medication(id: 21, name: 'Clopidogrel 75mg', active: true, cycle: 1, last: past[1], next: today, stock: -10, started: past[120], total: 108),
                                Medication(id: 22, name: 'Warfarin 5mg', active: true, cycle: 1, last: today, next: future[0], stock: 48, started: past[200], total: 186),
                                Medication(id: 23, name: 'Hydrochlorothiazide 25mg', active: true, cycle: 1, last: past[1], next: future[0], stock: 30, started: past[150], total: 133),
                                Medication(id: 25, name: 'Omeprazole 20mg', active: false, cycle: 1, last: today, next: future[0], stock: 19, started: past[180], total: 144),
                                Medication(id: 24, name: 'Levothyroxine 50mcg', active: true, cycle: 1, last: past[5], next: past[4], stock: 43, started: past[300], total: 225),
                                Medication(id: 26, name: 'Citalopram 20mg', active: true, cycle: 2, last: past[1], next: future[1], stock: 6, started: past[90], total: 39),
                                Medication(id: 27, name: 'Fluoxetine 20mg', active: true, cycle: 2, last: past[2], next: future[0], stock: 32, started: past[200], total: 89),
                                Medication(id: 28, name: 'Prolia 60mg', active: true, cycle: 180, last: past[100], next: future[80], stock: 3, started: past[360], total: 2),
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
                            , child: const Text('Test with sample data', style: TextStyle(color: Colors.black), softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis,)
                          )
                        ),)
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
