import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../models/athlete_preview.dart';
import 'package:go_router/go_router.dart';

class AthleteWidget extends StatelessWidget {
  final AthletePreview athletePreview;

  const AthleteWidget({super.key, required this.athletePreview});

  @override
  Widget build(BuildContext ctx) {
    final theme = Theme.of(ctx);
    final mono = theme.extension<AppTextStyles>()!;

    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {ctx.push("/athlete/${athletePreview.id}");},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "${athletePreview.name} ${athletePreview.surname}",
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyLarge,
              ),
            ),
            Text(athletePreview.birthDate, style: mono.monoDate),
          ],
        ),
      ),
    );
  }
}
