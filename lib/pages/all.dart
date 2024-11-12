import 'package:flutter/material.dart';

class All extends StatefulWidget {
  const All({super.key});
  
  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('All'))
    );
  }
}