import 'package:flutter/material.dart';
import '../models/team_preview.dart';
import 'package:go_router/go_router.dart';

class TeamWidget extends StatelessWidget {
  final TeamPreview teamPreview;

  const TeamWidget({super.key, required this.teamPreview});

  @override
  Widget build(BuildContext ctx) {
    final theme = Theme.of(ctx);

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {ctx.push("/team/${teamPreview.id}");},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                teamPreview.name,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            Text(
              teamPreview.id,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
