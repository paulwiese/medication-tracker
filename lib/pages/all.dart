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
  late var box;
  late List<Medication> m;
  late List<Medication> items;
  late DateTime today;

  bool edit = false;

  @override
  void initState() {
    super.initState();
    box = Hive.box('medication');
    update();
  }

  void update() async {
    setState(() {
      today = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      m = box.get(0);
      items = [];
      for (int i = 0; i < m.length; i++) {
        items.add(m[i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
                child: Container(
      margin: const EdgeInsets.all(22),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        int maxID = -1;
                        for (int i = 0; i < m.length; i++) {
                          if (m[i].id > maxID) {
                            maxID = m[i].id;
                          }
                        }
                        maxID++;
                        setState(() {
                          m.add(Medication(
                              id: maxID,
                              name: 'Medication $maxID',
                              active: true,
                              cycle: 7,
                              last: DateTime(0),
                              next: DateTime.now(),
                              stock: 10,
                              started: DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day),
                              total: 0));
                        });
                        update();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              id: maxID,
                              update: update,
                            ),
                          ),
                        );
                      },
                      child: const Text('add new'))),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                        });
                        update();
                      },
                      child: edit ? const Text('done') : const Text('edit list'))),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (!edit) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          id: items[index].id,
                          update: update,
                        ),
                      ),
                    );
                  }
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                      title: Text(items[index].name),
                      leading: edit ? 
                        IconButton(
                          onPressed: () {
                            setState(() {
                              m.remove(items[index]);
                              box.put(0,m);
                            });
                            update();
                          },
                          icon: const Icon(Icons.delete_forever_rounded))
                        : null,
                      trailing: SizedBox(
                          width: 120,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                        child: Text('next:'),
                                      ),
                                      SizedBox(
                                          width: 50,
                                          child: Builder(builder: (context) {
                                            var diff = items[index]
                                                .next
                                                .difference(today)
                                                .inDays;
                                            if (diff < 0) {
                                              return Text(
                                                  '${items[index].next.difference(today).inDays.toString()}d',
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 205, 40, 40)));
                                            } else if (diff == 0) {
                                              return const Text('Today',
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 100, 207, 50)));
                                            } else {
                                              return Text(
                                                '${items[index].next.difference(today).inDays.toString()}d',
                                              );
                                            }
                                          })),
                                    ],
                                  )),
                              Container(
                                  margin: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                        child: Text('stock:'),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child:
                                            Text(items[index].stock.toString()),
                                      )
                                    ],
                                  )),
                            ],
                          ))),
                ),
              );
            },
          )
        ],
      ),
    ))));
  }
}
