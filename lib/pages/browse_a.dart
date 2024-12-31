import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'index.dart';
import 'package:medication_tracker/models/medication.dart';

class BrowseA extends StatefulWidget {
  const BrowseA({super.key});

  @override
  State<BrowseA> createState() => _BrowseAState();
}

class _BrowseAState extends State<BrowseA> {
  var box = Hive.box('medication');

  List<Medication> all = [];
  List<Medication> m = [];

  List<Medication> filtered = [];

  List<String> categories = [
    'All Categories',
    'Pain Relievers',
    'Antibiotics',
    'Allergy Relief',
    'Cold and Flu Remedies',
    'Digestive Health',
    'Heart Health',
    'Mental Health',
    'Diabetes Management',
    'Skin Treatments',
    'Sleep Aid',
    'Vitamins and Supplements'
  ];

  String selectedCategory = 'All Categories';

  @override
  void initState() {
    super.initState();
    all = List<Medication>.from(box.get(5)?.map((med) => med.clone()) ?? []);
    m = List<Medication>.from(box.get(0)?.map((med) => med.clone()) ?? []);

    all.sort((a, b) => a.name.compareTo(b.name));

    filtered = all;
  }

  void update() {
    
  }

  void filterByCategory(String category) {
    setState(() {
      if (category == 'All Categories') {
        filtered = all;
      } else {
        filtered = all.where((med) => med.category == category).toList();
      }
    });
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Pain Relievers':
        return Colors.redAccent;
      case 'Antibiotics':
        return Colors.blueAccent;
      case 'Allergy Relief':
        return Colors.orangeAccent;
      case 'Cold and Flu Remedies':
        return Colors.lightBlueAccent;
      case 'Digestive Health':
        return Colors.greenAccent;
      case 'Heart Health':
        return Colors.pinkAccent;
      case 'Mental Health':
        return Colors.purpleAccent;
      case 'Diabetes Management':
        return Colors.tealAccent;
      case 'Skin Treatments':
        return Colors.brown;
      case 'Sleep Aid':
        return Colors.indigoAccent;
      case 'Vitamins and Supplements':
        return Colors.yellow.shade400;
      default:
        return Colors.grey; // Default color
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Pain Relievers':
        return Icons.healing;
      case 'Antibiotics':
        return Icons.medication;
      case 'Allergy Relief':
        return Icons.grass;
      case 'Cold and Flu Remedies':
        return Icons.sick;
      case 'Digestive Health':
        return Icons.health_and_safety;
      case 'Heart Health':
        return Icons.favorite;
      case 'Mental Health':
        return Icons.psychology;
      case 'Diabetes Management':
        return Icons.bloodtype;
      case 'Skin Treatments':
        return Icons.spa;
      case 'Sleep Aid':
        return Icons.bedtime;
      case 'Vitamins and Supplements':
        return Icons.local_florist;
      default:
        return Icons.category; // Default icon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Browse-A'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward),
                      underline: const SizedBox(),
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      alignment: Alignment.centerLeft,
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                            value: category,
                            child: Row(children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(
                                      category),
                                  borderRadius:
                                      BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  _getCategoryIcon(category),
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 15,),
                              Text(
                                category,
                                style: const TextStyle(color: Colors.black),
                                textAlign: TextAlign.left,
                              ),
                            ]));
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedCategory = newValue;
                            filterByCategory(newValue);
                          });
                        }
                      },
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(10),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              id: filtered[index].id,
                              update: () {},
                              preview: true,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(
                                  6), // Add padding for better spacing
                              decoration: BoxDecoration(
                                color: _getCategoryColor(
                                    filtered[index].category), // Dynamic color
                                borderRadius:
                                    BorderRadius.circular(8), // Rounded corners
                              ),
                              child: Icon(
                                _getCategoryIcon(
                                    filtered[index].category), // Dynamic icon
                                color: Colors.white, // Icon color
                                size: 24, // Icon size
                              ),
                            ),
                            title: Text(filtered[index].name),
                            trailing: SizedBox(
                                width: 60,
                                child: Row(
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.all(5),
                                        child: SizedBox(
                                            width: 50,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Medication med = filtered[index].clone();

                                                int maxID = box.get(7);
                                                maxID++;
                                                med.id = maxID;
                                                box.put(7, maxID);
                                                m.add(med);
                                                box.put(0, m);

                                                // open detail screen
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailScreen(
                                                      id: maxID,
                                                      update: update,
                                                      preview: false,
                                                    ),
                                                  ),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.zero,
                                              ),
                                              child: const Center(
                                                  child: Icon(Icons.add,
                                                      color: Colors.green)),
                                            )))
                                  ],
                                ))),
                      ),
                    );
                  },
                )
              ],
            )));
  }
}
