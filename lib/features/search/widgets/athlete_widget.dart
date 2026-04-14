import 'package:flutter/material.dart';
import '../models/athlete_preview.dart';

class AthleteWidget extends StatelessWidget {
  final AthletePreview athletePreview;

  const AthleteWidget({super.key, required this.athletePreview});

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text("${athletePreview.name} ${athletePreview.surname}", overflow: TextOverflow.ellipsis),
          Text(athletePreview.birthDate),
        ],
      ),
    );
  }
}
