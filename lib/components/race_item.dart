import 'package:flutter/material.dart';
import 'package:mykayak/views/races_screen.dart';

class RaceItem extends StatelessWidget {
  final String id;
  final int distance;
  final String division;
  final String category;
  final String boat;
  final String level;
  const RaceItem({super.key, required this.id, required this.distance, required this.division, required this.category, required this.boat, required this.level});
  @override
  Widget build(BuildContext context) {
    String label = "";

    label += boat;
    label += " ";
    label += distance.toString();
    label += "m ";
    switch (division) {
      case "ALA":
        label += "Allievi A ";
      case "ALB":
        label += "Allievi B ";
      case "CDA":
        label += "Cadetti A ";
      case "CDB":
        label += "Cadetti B ";
      case "RA1":
        label += "Ragazzi primo anno "; // TODO: make sure it's not too long
      case "RAG":
        label += "Ragazzi ";
      case "JUN":
        label += "Junior ";
      case "U23":
        label += "Under 23 ";
      case "SEN":
        label += "Senior ";
      case "DRA":
        label += "DIR A ";
      case "DRB":
        label += "DIR B ";
      default:
        if (division.startsWith("MA")){
          label += "Master ${division[2]} ";
        }
    }

    switch (category) {
      case "M":
        label += "Maschile";
      case "F":
        label += "Femminile";
      case "X":
        label += "Misto";
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10
      ),
      child: InkWell(
        onTap: () {Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RacesScreen(meetId:""),
        ));},
        child: Text(label, style:TextStyle(fontSize:18), overflow: TextOverflow.ellipsis,)
      ),
    );
  }
}