import 'package:flutter/material.dart';
import '../models/team_preview.dart';
import 'package:go_router/go_router.dart';

class TeamWidget extends StatelessWidget {
  final TeamPreview teamPreview;

  const TeamWidget({super.key, required this.teamPreview});

  @override
  Widget build(BuildContext ctx) {
    return InkWell(
      onTap: () {ctx.push("/team/${teamPreview.id}");},
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(teamPreview.name, overflow: TextOverflow.ellipsis),
            Text(teamPreview.id),
          ],
        ),
      ),
    );
  }
}
