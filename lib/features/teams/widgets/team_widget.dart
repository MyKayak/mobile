import 'package:flutter/material.dart';
import 'package:mykayak/features/teams/models/team_preview.dart';

class TeamWidget extends StatelessWidget {
  final TeamPreview teamPreview;

  TeamWidget({super.key, required this.teamPreview});

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(teamPreview.name, overflow: TextOverflow.ellipsis),
          Text(teamPreview.id),
        ],
      ),
    );
  }
}
