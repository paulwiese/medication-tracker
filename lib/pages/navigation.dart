import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'index.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});
  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  int currentPageIndex = 0;

  late final Box box;

  @override
  void initState() {
    super.initState();
    box = Hive.box('medication'); // Open the Hive box
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (context, Box box, _) {
        final bool vb = box.get(6, defaultValue: false);

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
              NavigationDestination(icon: Icon(Icons.search), label: 'Browse'),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          body: <Widget>[
            const Home(),
            const All(),
            vb ? const BrowseB() : const BrowseA(),
            const Settings(),
          ][currentPageIndex],
        );
      },
    );
  }
}
