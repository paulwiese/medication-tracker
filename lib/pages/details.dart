import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medication_tracker/models/medication.dart';

class DetailScreen extends StatefulWidget{
  
  final int id;
  final Function update;

  final bool preview;

  const DetailScreen({super.key, required this.id, required this.update, required this.preview});
  @override
  State<DetailScreen> createState() => DetailScreenState();

}

class DetailScreenState extends State<DetailScreen> {

  late List<Medication> medication;
  late Medication m;
  late TextEditingController _nameController;
  late bool active;
  late int cycle;
  late DateTime last;
  late DateTime next;
  late TextEditingController _stockController;
  late DateTime started;
  late int total;
  late bool prescription;
  late TextEditingController _categoryController;
  late TextEditingController _infoController;

  late List<Medication> all;

  double space = 25;

  var box = Hive.box('medication');
  int index = 0;

  int h = 0;

  bool help = true;

  double hspace = 12;

  bool emp = false;

  @override
  void initState() {
    super.initState();

    medication = List<Medication>.from(box.get(0));

    all = List<Medication>.from(box.get(5));

    if(widget.preview) {

      for(int i = 0; i < all.length; i++) {
        if(all[i].id == widget.id) {
          m = all[i];
          index = i;
          break;
        }
      }

    }
    else {
      
      for(int i = 0; i < medication.length; i++) {
        if(medication[i].id == widget.id) {
          m = medication[i];
          index = i;
          break;
        }
      }

    }

    _nameController = TextEditingController(text: m.name);
    active = m.active;
    cycle = m.cycle;
    last = m.last;
    next = m.next;
    _stockController = TextEditingController(text: m.stock.toString());
    started = m.started;
    total = m.total;
    _categoryController = TextEditingController(text: m.category);
    prescription = m.prescription;
    _infoController = TextEditingController(text: m.info);

    help = box.get(4);

  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(title: Text(m.name),),
      body: Padding(padding: const EdgeInsets.all(30), child: 
        ListView(
          children: [
            widget.preview ? const SizedBox(height: 0,) : ElevatedButton(
              onPressed: () {
                if(_nameController.text.isEmpty || _stockController.text.isEmpty || _categoryController.text.isEmpty || _infoController.text.isEmpty) {
                  setState(() {
                    emp = true;
                  });
                }
                else {
                  setState(() {
                    m.name = _nameController.text;
                    m.active = active;
                    m.cycle = cycle;
                    m.last = last;
                    m.next = next;
                    m.stock = (_stockController.text.isEmpty || int.tryParse(_stockController.text) == null) ? 0 : int.parse(_stockController.text);
                    m.started = started;
                    m.total = total;
                    m.category = _categoryController.text;
                    m.prescription = prescription;
                    m.info = _infoController.text;

                    box.put(0,medication);
                    
                    emp = false;
                  });
                }
                widget.update();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_outlined),
                  SizedBox(width: 20,),
                  Text('Save Changes')
                ],
              )
            ),
            SizedBox(height: space,),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            emp ? const Text(
                'Please enter a valid medication name and save.',
                style: TextStyle(fontSize: 12.0, color: Colors.red),
              ) : const SizedBox(height:0),
            SizedBox(height: space,),
            Row(
              children: [
                const Text('Active'),
                SizedBox(width: hspace,),
                Switch(
                  value: active,
                  onChanged: (value) {
                    setState(() {
                      active = value;
                    });
                  },
                ),
                const SizedBox(width: 15,),
                help ? IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h = 0;
                    _showDescriptionDialog(context);
                  },
                ) : const SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Intake Cycle:  $cycle days'),
                SizedBox(width: hspace,),
                Container(
                  width: 28,
                  height: 28,
                  decoration:BoxDecoration(color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cycle++;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 7,),
                Container(
                  width: 28,
                  height: 28,
                  decoration:BoxDecoration(color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (cycle > 1) {
                        setState(() {
                          cycle--;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: hspace,),
                help ? IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h = 1;
                    _showDescriptionDialog(context);
                  },
                ) : const SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Last Intake:  ${'${last.toLocal()}'.split(' ')[0]}'),
                SizedBox(width: hspace,),
                IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: last,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          last = pickedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(width: hspace,),
                  help ? IconButton(
                    icon: const Icon(Icons.help_outline),
                    tooltip: "Info",
                    onPressed: () {
                      h = 2;
                      _showDescriptionDialog(context);
                    },
                  ) : const SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Next Intake:  ${'${next.toLocal()}'.split(' ')[0]}'),
                SizedBox(width: hspace,),
                IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: next,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          next = pickedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(width: hspace,),
                help ? IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h = 3;
                    _showDescriptionDialog(context);
                  },
                ) : const SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Expanded(child:
                TextFormField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(labelText: 'Stock'),
                )),
                SizedBox(width: hspace,),
                help ? IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h = 4;
                    _showDescriptionDialog(context);
                  },
                ) : const SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Started:  ${'${started.toLocal()}'.split(' ')[0]}'),
                SizedBox(width: hspace,),
                IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: started,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          started = pickedDate;
                        });
                      }
                    },
                  ),
                  SizedBox(width: hspace,),
                help ? IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h = 5;
                    _showDescriptionDialog(context);
                  },
                ) : const SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Total number of Intakes: $total'),
                SizedBox(width: hspace,),
                help ? IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h = 6;
                    _showDescriptionDialog(context);
                  },
                ) : const SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                const Text('Prescription'),
                SizedBox(width: hspace,),
                Switch(
                  value: prescription,
                  onChanged: (value) {
                    setState(() {
                      prescription = value;
                    });
                  },
                ),
                const SizedBox(width: 15,),
                help ? IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h = 7;
                    _showDescriptionDialog(context);
                  },
                ) : const SizedBox(width: 0,),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Expanded(child:
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(labelText: 'Category'),
                  )
                ),
                SizedBox(width: hspace,),
                help ? IconButton(
                  icon: const Icon(Icons.help_outline),
                  tooltip: "Info",
                  onPressed: () {
                    h = 8;
                    _showDescriptionDialog(context);
                  },
                ) : const SizedBox(width: 0,),
              ],
            ),          
            emp ? const Text(
                'Please enter a valid medication category and save.',
                style: TextStyle(fontSize: 12.0, color: Colors.red),
              ) : const SizedBox(height:0),
            SizedBox(height: space,),
            
            TextFormField(
              controller: _infoController,
              decoration: const InputDecoration(labelText: 'Info'),
              maxLines: 6
            ),
            emp ? const Text(
                'Please enter a valid medication info text and save.',
                style: TextStyle(fontSize: 12.0, color: Colors.red),
              ) : const SizedBox(height:0),

            const SizedBox(height: 60,),
            widget.preview ? const SizedBox(height: 0,) : ElevatedButton(
              onPressed: () {
                setState(() {
                  medication.remove(m);
                  box.put(0,medication);
                });
                widget.update();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[200]),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Delete'),
                  Icon(Icons.delete_forever_rounded)
                ],
              )
            ),
            SizedBox(height: space,),
            
          ],
        )
      ,),
    );
  }

  void _showDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> title = [
          'Active/Passive Switch',
          'Intake Cycle',
          'Last Intake', 
          'Next Intake',
          'Stock',
          'Start',
          'Total number of Intakes',
          'Prescription',
          'Category'
        ];



        List<String> info = [
          'Active medication-plans are displayed on the home screen when the date for the next sceduled intake is reached or exceeded.',
          'After tracking the intake of a medication via the Home-Screen the next intake is automatically sceduled according to the specified input cycle.',
          'The date of the last intake of a medication is automatically saved when the user tracks it via the Home-Screen.',
          'The date of the next intake is automatically sceduled according to the specified input cycle, when the user tracks taking the medication via the Home-Screen.',
          'The available stock is automatically decremented when the user tracks taking the medication via the Home-Screen.', 
          'This field reflects the date when the user started using the medication.',
          'The total number of intakes is automatically incremented, when the user tracks taking the medication via the Home-Screen',
          'Indicates whether a prescription is needed for this medication.',
          'Indicates the category of the medication.'
        ];

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title[h],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  info[h],
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text("Close"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}