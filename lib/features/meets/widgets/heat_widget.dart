import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../models/heat.dart';

class HeatWidget extends StatelessWidget {
  final Heat heat;

  const HeatWidget({super.key, required this.heat});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mono = theme.extension<AppTextStyles>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 6),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theme.colorScheme.outline.withAlpha(60),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Batteria ${heat.index}",
                  style: theme.textTheme.titleSmall,
                ),
                Text(
                  heat.startTime.split(" ")[1],
                  style: mono.monoTimeSmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          ...heat.performances.map(
            (performance) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 32,
                    child: Column(
                      children: [
                        Text(
                          performance.placement.toString(),
                          style: mono.monoMedal,
                        ),
                        Text(
                          "(${performance.lane})",
                          style: theme.textTheme.bodySmall?.copyWith(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...performance.athletes.map(
                            (athlete) => Text(
                              "${athlete.name} ${athlete.surname}",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      performance.teamName,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    performance.status.isEmpty
                        ? performance.timeLabel
                        : performance.status,
                    style: mono.monoTime,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
