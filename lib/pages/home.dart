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

  var box = Hive.box('medication');

  bool help = true;
  int h = 0;

  @override
  void initState() {
    super.initState();
    help = box.get(4);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:
          SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  child: Text('👋 Hello, ${Hive.box('medication').get(2)}', style: const TextStyle(fontSize: 32.0),),
                ),
                Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 240, 250),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color.fromARGB(255, 167, 167, 167), width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15, top: 10),
                            child: const Text('Missed',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 5,),
                          help ? Padding(padding: const EdgeInsets.symmetric(vertical: 3), child:IconButton(
                            icon: const Icon(Icons.help_outline),
                            tooltip: "Info",
                            onPressed: () {
                              h = 0;
                              _showDescriptionDialog(context);
                            },
                          )) : const SizedBox(width: 0,),
                        ],
                      ),
                      
                      ConstrainedBox(constraints: const BoxConstraints(maxHeight: 200), child: const _PastList(),)
                    ],
                  )
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 5),
                      child: const Text('Today',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 5,),
                      help ? Padding(padding: const EdgeInsets.symmetric(vertical: 3), child: IconButton(
                        icon: const Icon(Icons.help_outline),
                        tooltip: "Info",
                        onPressed: () {
                          h = 1;
                          _showDescriptionDialog(context);
                        },
                      )) : const SizedBox(width: 0,),
                  ],
                ),
                
                const _TodayList()
            ],
          ) 
        ),
      
    );
  }

  void _showDescriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> title = [
          'Past List',
          'Today List',
        ];



        List<String> info = [
          'All medications that were sceduled for past days with no tracked intake are listed here. Use the check button to track intake and trigger automatic resceduling.',
          'All medications that are sceduled for intake today are listed here. Use the check button to track intake and trigger automatic resceduling.',
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

class _TodayList extends StatefulWidget {
  const _TodayList();

  @override
  State<_TodayList> createState() => _TodayListState();
}

class _TodayListState extends State<_TodayList> {
  
  late var box;
  late List<Medication> m;
  late List<Medication> items;
  late DateTime today;

  @override
  void initState() {
    super.initState();
    box = Hive.box('medication');
    items = [];
    m = [];
    update();

  }

  void update() async {
    setState(() {
      today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      m = List<Medication>.from(box.get(0));
      items = [];
      for (int i = 0; i < m.length; i++) {
        if(m[i].active && m[i].next.year == today.year && m[i].next.month == today.month && m[i].next.day == today.day) {
          items.add(m[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return items.isEmpty ?
    Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: const SizedBox(
        width: double.infinity,
        height: 40,
        child: Align(alignment: Alignment.center, child: Text('No further medication scheduled for today 🙂'))
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
                builder: (context) => DetailScreen(id: items[index].id, update: update, preview: false,),
              ),
            );
          },
          child: Card(
            color: Colors.white,
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
                              Medication med = items[index];
                              setState(() {
                                m.remove(med);
                                
                                med.last = today;
                                med.next = today.add(Duration(days: items[index].cycle));
                                med.stock -= 1;
                                med.total++;

                                m.add(med);

                                box.put(0,m);
                              });
                              update();
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
  
  late var box;
  late List<Medication> m;
  late List<Medication> items;
  late DateTime today;

  @override
  void initState() {
    super.initState();
    box = Hive.box('medication');
    items = [];
    m = [];
    update();

  }

  void update() {
    setState(() {
      today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
      
      var med = box.get(0);
      m = List<Medication>.from(med);
      items = [];
      for (int i = 0; i < m.length; i++) {
        if(
        m[i].active &&
        m[i].next.year < today.year ||
        (m[i].next.year == today.year && m[i].next.month < today.month) ||
        (m[i].next.year == today.year && m[i].next.month == today.month && m[i].next.day < today.day)
        ) {
          items.add(m[i]);
        }
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {

    return items.isEmpty ?
    Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: const SizedBox(
        width: double.infinity,
        height: 40,
        child: Align(alignment: Alignment.center, child: Text('No missed medication 🙂'))
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
                builder: (context) => DetailScreen(id: items[index].id, update: update, preview: false,),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(items[index].name),
              trailing:
                SizedBox(width: 92, child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3), child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 40, child: Text('next:'),),    
                            SizedBox(width: 40, child: Text('${items[index].next.difference(today).inDays.toString()}d', style: const TextStyle(color: Color.fromARGB(255, 205, 40, 40))),),    
                          ],
                        )
                      ),
                      Container(margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3), child:
                        SizedBox(width: 40, child: 
                          ElevatedButton(
                            onPressed: () {
                              
                              Medication med = items[index];
                              setState(() {
                                m.remove(med);
                                
                                med.last = today;
                                med.next = today.add(Duration(days: items[index].cycle));
                                med.stock -= 1;
                                med.total++;

                                m.add(med);

                                box.put(0,m);
                              });
                              update();

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