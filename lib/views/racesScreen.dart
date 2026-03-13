import 'package:flutter/material.dart';

class RacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return ListView();
        });
      },
    );
  }

}