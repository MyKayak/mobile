import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';
import '../models/athlete_preview.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_card.dart';

class AthleteWidget extends StatelessWidget {
  final AthletePreview athletePreview;

  const AthleteWidget({super.key, required this.athletePreview});

  @override
  Widget build(BuildContext ctx) {
    final theme = Theme.of(ctx);
    final mono = theme.extension<AppTextStyles>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: AppCard(
        onTap: () {
          HapticFeedback.lightImpact();
          ctx.push("/athlete/${athletePreview.id}");
        },
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${athletePreview.name} ${athletePreview.surname}",
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Text(athletePreview.birthDate, style: mono.monoDate),
          ],
        ),
      ),
    );
  }
}
