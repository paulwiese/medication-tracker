import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'index.dart';

import 'package:medication_tracker/models/medication.dart';

class BrowseB extends StatefulWidget {
  const BrowseB({super.key});
  
  @override
  State<BrowseB> createState() => _BrowseBState();
}

class _BrowseBState extends State<BrowseB> {
  
  var box = Hive.box('medication');

  List<Medication> all = [];

  List<String> categories = [
    //'All Categories',
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('Browse-B'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            String category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Swipe(category: category,),
                          ),
                        );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _getCategoryColor(category),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getCategoryIcon(category),
                        color: Colors.white,
                        size: 40,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),

    );
  }

}