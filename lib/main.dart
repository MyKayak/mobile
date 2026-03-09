import 'package:flutter/material.dart';
import '../views/meetsScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: MeetsScreen()),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {print(value);},
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.developer_mode),
              label: "Dev Options",
            ),
          ],
        ),
      ),
    );
  }
}
