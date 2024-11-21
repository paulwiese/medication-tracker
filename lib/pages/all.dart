import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medication_tracker/models/medication.dart';
import 'index.dart';

class All extends StatefulWidget {
  const All({super.key});
  
  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  
  final _medication = Hive.box('medication');

  @override
  Widget build(BuildContext context) {

    var m = _medication.get(0);
    List<Medication> items = [];

    var today = DateTime.now();

    for (int i = 0; i < m.length; i++) {
      items.add(m[i]);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('All'),),
      body:
        Center(
          child:
            Container(
              margin: const EdgeInsets.all(12),
              child:
                ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(id: items[index].id),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(items[index].name),
                        trailing:
                            SizedBox(width: 120, child:
                              Row(
                                children: [
                                  Container(margin: const EdgeInsets.all(5), child:
                                    Column(
                                      children: [
                                        const SizedBox(width: 50, child: Text('next:'),),    
                                        SizedBox(
                                          width: 50, 
                                          child: 
                                            Builder(builder: (context) {
                                              var diff = items[index].next.difference(today).inDays;
                                              if(diff < 0) {
                                                return Text(
                                                  '${items[index].next.difference(today).inDays.toString()}d',
                                                  style: const TextStyle(color: Color.fromARGB(255, 205, 40, 40))
                                                );
                                              }
                                              else if (diff == 0) {
                                                return const Text(
                                                  'Today',
                                                  style: TextStyle(color: Color.fromARGB(255, 100, 207, 50))
                                                );
                                              }
                                              else {
                                                return Text(
                                                  '${items[index].next.difference(today).inDays.toString()}d',
                                                );
                                              }
                                            })
                                        ),    
                                      ],
                                    )
                                  ),
                                  Container(margin: const EdgeInsets.all(5), child:
                                    Column(
                                      children: [
                                        const SizedBox(width: 50, child: Text('stock:'),),    
                                        SizedBox(width: 50, child: Text(items[index].stock.toString()),)
                                      ],
                                    )
                                  ),
                                ],
                              )
                            )
                      ),
                    ),
                  );
                },
                )
            )
          )
    );

  }
}