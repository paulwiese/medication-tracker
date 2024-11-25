import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'index.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});
  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  var box = Hive.box('medication');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue[100],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'All',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        const Home(),
        const All(),
        const Settings(),
      ][currentPageIndex],
    );
  }
}