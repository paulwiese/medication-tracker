import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medication_tracker/models/medication.dart';
import 'index.dart';

class Swipe extends StatefulWidget {
  final String category;

  const Swipe({super.key, required this.category});
  @override
  State<Swipe> createState() => SwipeState();
}

class SwipeState extends State<Swipe> {
  int currentPageIndex = 0;

  late final Box box;

  late String category;

  List<Medication> all = [];

  @override
  void initState() {
    super.initState();
    box = Hive.box('medication'); // Open the Hive box

    category = widget.category;
    all = List<Medication>.from(box.get(5));
    all = all.where((med) => med.category == category).toList();
  }

  void update() {

  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Pain Relievers':
        return Colors.red[50] ?? Colors.grey.shade100;
      case 'Antibiotics':
        return Colors.blue[50] ?? Colors.grey.shade100;
      case 'Allergy Relief':
        return Colors.orange[50] ?? Colors.grey.shade100;
      case 'Cold and Flu Remedies':
        return Colors.lightBlue[50] ?? Colors.grey.shade100;
      case 'Digestive Health':
        return Colors.lightGreen[50] ?? Colors.grey.shade100;
      case 'Heart Health':
        return Colors.pink[50] ?? Colors.grey.shade100;
      case 'Mental Health':
        return Colors.purple[50] ?? Colors.grey.shade100;
      case 'Diabetes Management':
        return Colors.teal[50] ?? Colors.grey.shade100;
      case 'Skin Treatments':
        return Colors.brown[50] ?? Colors.grey.shade100;
      case 'Sleep Aid':
        return Colors.indigo[50] ?? Colors.grey.shade100;
      case 'Vitamins and Supplements':
        return Colors.yellow[50] ?? Colors.grey.shade100;
      default:
        return Colors.grey.shade100;;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: PageView.builder(
          itemCount: all.length,
          itemBuilder: (context, index) {
            Medication m = all[index];

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                color: _getCategoryColor(category),
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          m.name,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                          width: double
                              .infinity, // Makes the icon button stretch across the screen
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                borderRadius: BorderRadius.circular(8)),
                            child: IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                int maxID = box.get(7);
                                maxID++;

                                Medication x = m.clone();

                                x.id = maxID;
                                box.put(7, maxID);
                                
                                List<Medication> meds = box.get(0);
                                meds.add(x);

                                box.put(0, meds);

                                // open detail screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: maxID,
                                      update: update,
                                      preview: false,
                                    ),
                                  ),
                                );
                              },
                              iconSize: 40, // Adjust icon size as needed
                              padding: const EdgeInsets.all(4),
                              color: Colors.white,
                            ),
                          )),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Icon(
                            m.prescription
                                ? Icons.medical_services
                                : Icons.cancel,
                            color: m.prescription ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Prescription required: ${m.prescription ? 'Yes' : 'No'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: m.prescription ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      Text(
                        'Info:\n${m.info}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
