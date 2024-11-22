import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medication_tracker/models/medication.dart';

class DetailScreen extends StatefulWidget{
  
  final int id;
  final Function update;

  const DetailScreen({super.key, required this.id, required this.update});
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

  double space = 25;

  var box = Hive.box('medication');
  int index = 0;

  @override
  void initState() {
    super.initState();

    medication = List<Medication>.from(box.get(0));

    for(int i = 0; i < medication.length; i++) {
      if(medication[i].id == widget.id) {
        m = medication[i];
        index = i;
        break;
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
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(title: Text(m.name),),
      body: Padding(padding: const EdgeInsets.all(40), child: 
        ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  m.name = _nameController.text;
                  m.active = active;
                  m.cycle = cycle;
                  m.last = last;
                  m.next = next;
                  m.stock = (_stockController.text.isEmpty || int.tryParse(_stockController.text) == null) ? 0 : int.parse(_stockController.text);
                  m.started = started;
                  m.total = total;
                  box.put(index,medication);
                  widget.update();
                });
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
            SizedBox(height: space,),
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Active'),
                const SizedBox(width: 20,),
                Switch(
                  value: active,
                  onChanged: (value) {
                    setState(() {
                      active = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Intake Cycle:   $cycle days'),
                const SizedBox(width: 20,),
                Container(
                  decoration:BoxDecoration(color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cycle++;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10,),
                Container(
                  decoration:BoxDecoration(color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (cycle > 1) {
                        setState(() {
                          cycle--;
                        });
                      }
                    },
                  ),
                )
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Last taken:  ${'${last.toLocal()}'.split(' ')[0]}'),
                const SizedBox(width: 20,),
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
              ],
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Next intake:  ${'${next.toLocal()}'.split(' ')[0]}'),
                const SizedBox(width: 20,),
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
              ],
            ),
            SizedBox(height: space,),
            TextFormField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(labelText: 'Stock'),
            ),
            SizedBox(height: space,),
            Row(
              children: [
                Text('Started:  ${'${started.toLocal()}'.split(' ')[0]}'),
                const SizedBox(width: 20,),
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
              ],
            ),
            SizedBox(height: space,),
            Text('Total number of intakes: $total'),
            SizedBox(height: space,),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  medication.remove(m);
                });
                widget.update();
                Navigator.pop(context);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Delete'),
                  Icon(Icons.delete_forever_rounded)
                ],
              )
            )
          ],
        )
      ,),
    );
  }
}