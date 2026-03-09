import 'package:flutter/material.dart';

class DevOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(children: [
          Text("Indirizzo IP dell'API"),
          TextField(),
        ],),
      ],
    );
  }
}