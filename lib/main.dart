import 'package:flutter/material.dart';
import 'views/meets_screen.dart';
import 'views/settings_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _views = [
    MeetsScreen(),
    SettingsScreen(),
  ];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: _views[_pageIndex]),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState((){_pageIndex = value;});
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Impostazioni",
            ),
          ],
        ),
      ),
    );
  }
}
