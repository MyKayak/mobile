import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/athlete_rankings/providers/ranking_provider.dart';
import 'package:mykayak/features/athlete_rankings/widgets/options.dart';
import 'package:mykayak/core/utils/time_formatter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/shimmer.dart';
import '../../../core/widgets/app_card.dart';

class AthleteRankingsScreen extends ConsumerWidget {
  const AthleteRankingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRankings = ref.watch(rankingsProvider);
    final theme = Theme.of(context);
    final mono = theme.extension<AppTextStyles>()!;

    return Column(
      children: [
        const AthleteRankingOptions(),
        Expanded(
          child: asyncRankings.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final rankingEntryData = data[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: AppCard(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push('/athlete/${rankingEntryData.athleteId}');
                    },
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 32,
                          child: Text(
                            '${index + 1}',
                            style: mono.monoMedal.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${rankingEntryData.athleteName} ${rankingEntryData.athleteSurname}",
                                style: theme.textTheme.titleSmall?.copyWith(fontSize: 15),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${rankingEntryData.boat} ${rankingEntryData.distance}m • ${CategoryFormatter.formatCategory(rankingEntryData.category)}",
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          rankingEntryData.timeLabel,
                          style: mono.monoTime.copyWith(color: theme.colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            loading: () => Shimmer(
              child: ListView.builder(
                itemCount: 10,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withAlpha(50),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.colorScheme.outline.withAlpha(80), width: 0.5),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Row(
                      children: [
                        SkeletonBox(width: 20, height: 20, borderRadius: 10),
                        SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonBox(width: 140, height: 16),
                              SizedBox(height: 6),
                              SkeletonBox(width: 100, height: 12),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        SkeletonBox(width: 60, height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            error: (err, stack) => Center(child: Text(err.toString())),
          ),
        ),
      ],
    );
  }
}
