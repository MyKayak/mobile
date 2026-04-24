import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/team_preview.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';

class TeamWidget extends StatelessWidget {
  final TeamPreview teamPreview;

  const TeamWidget({super.key, required this.teamPreview});

  @override
  Widget build(BuildContext ctx) {
    final theme = Theme.of(ctx);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: AppCard(
        onTap: () {
          HapticFeedback.lightImpact();
          ctx.push("/team/${teamPreview.id}");
        },
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                teamPreview.name,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
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
