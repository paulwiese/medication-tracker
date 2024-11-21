import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medication_tracker/models/medication.dart';
import 'index.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 232, 230), // Background color of the box
                    borderRadius: BorderRadius.circular(14), // Rounded corners
                    border: Border.all(color: const Color.fromARGB(255, 167, 167, 167), width: 1), // Border
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 15, top: 10),
                        child: const Text('Missed',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ConstrainedBox(constraints: const BoxConstraints(maxHeight: 200), child: const _PastList(),)
                    ],
                  )
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                  child: const Text('Today',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const _TodayList()
            ],
          ) 
        ),
      
    );
  }
}

class _TodayList extends StatefulWidget {
  const _TodayList();

  @override
  State<_TodayList> createState() => _TodayListState();
}

class _TodayListState extends State<_TodayList> {
  
  final _medication = Hive.box('medication');

  @override
  Widget build(BuildContext context) {

    var m = _medication.get(0);
    var items = [];

    var today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    for (int i = 0; i < m.length; i++) {
      if(m[i].next.year == today.year && m[i].next.month == today.month && m[i].next.day == today.day) {
        items.add(m[i]);
      }
    }

    return items.isEmpty ?
    Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: const SizedBox(
        width: double.infinity,
        height: 40,
        child: Align(alignment: Alignment.center, child: Text('No further medication sceduled today :)'))
      )
    )
    : ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(id: index),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(items[index].name),
              trailing: 
                SizedBox(width: 60, child:
                  Row(
                    children: [
                      Container(margin: const EdgeInsets.all(5), child:
                        SizedBox(width: 50, child: 
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                items[index].last = today;
                                items[index].next = today.add(Duration(days: items[index].cycle));
                                items[index].stock -= 1;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Center(child: Icon(Icons.check, color: Colors.green)),
                          )
                        )
                      )
                    ],
                  )
                )
            ),
          ),
        );
      },
    );
  }
}

class _PastList extends StatefulWidget {
  const _PastList();

  @override
  State<_PastList> createState() => _PastListState();
}

class _PastListState extends State<_PastList> {
  
  final _medication = Hive.box('medication');

  @override
  Widget build(BuildContext context) {

    var m = _medication.get(0);
    List<Medication> items = [];

    var today = DateTime.now();

    for (int i = 0; i < m.length; i++) {
      if(
      m[i].next.year < today.year ||
      (m[i].next.year == today.year && m[i].next.month < today.month) ||
      (m[i].next.year == today.year && m[i].next.month == today.month && m[i].next.day < today.day)
      ) {
        items.add(m[i]);
      }
    }

    return items.isEmpty ?
    Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: const SizedBox(
        width: double.infinity,
        height: 40,
        child: Align(alignment: Alignment.center, child: Text('No missed medication :)'))
      )
    )
    : ListView.builder(
      shrinkWrap: true,
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
                            SizedBox(width: 50, child: Text('${items[index].next.difference(today).inDays.toString()}d', style: const TextStyle(color: Color.fromARGB(255, 205, 40, 40))),),    
                          ],
                        )
                      ),
                      Container(margin: const EdgeInsets.all(5), child:
                        SizedBox(width: 50, child: 
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                items[index].last = today;
                                items[index].next = today.add(Duration(days: items[index].cycle));
                                items[index].stock -= 1;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: const Center(child: Icon(Icons.check, color: Colors.green)),
                          )
                        )
                      )
                    ],
                  )
                )
            ),
          ),
        );
      },
    );
  }
}