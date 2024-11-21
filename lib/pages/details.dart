import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medication_tracker/models/medication.dart';

class DetailScreen extends StatefulWidget{
  
  final int id;
  
  const DetailScreen({super.key, required this.id});
  @override
  State<DetailScreen> createState() => DetailScreenState();

}

class DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    List<Medication> a = Hive.box('medication').get(0);
    Medication m = Medication(id: 0, name: 'name', active: true, cycle: 0, last: DateTime(0), next: DateTime(0), stock: 0);

    for(int i = 0; i < a.length; i++) {
      if(a[i].id == widget.id) {
        m = a[i];
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(m.name),),
    );
  }
}