import 'package:flutter/material.dart';
import '../models/athlete_preview.dart';
import 'package:go_router/go_router.dart';

class AthleteWidget extends StatelessWidget {
  final AthletePreview athletePreview;

  const AthleteWidget({super.key, required this.athletePreview});

  @override
  Widget build(BuildContext ctx) {
    return InkWell(
      onTap: () {ctx.push("/athlete/${athletePreview.id}");},
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${athletePreview.name} ${athletePreview.surname}", overflow: TextOverflow.ellipsis),
            Text(athletePreview.birthDate),
          ],
        ),
      ),
    );
  }
}
