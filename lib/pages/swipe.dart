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

            return Info(id: m.id,);
          }),
    );
  }
}
