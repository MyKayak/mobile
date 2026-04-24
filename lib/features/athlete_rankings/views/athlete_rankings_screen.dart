import 'package:go_router/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/athlete_rankings/providers/ranking_provider.dart';
import 'package:mykayak/features/athlete_rankings/widgets/options.dart';
import 'package:mykayak/core/utils/time_formatter.dart';
import '../../../core/theme/app_theme.dart';

class AthleteRankingsScreen extends ConsumerWidget {
  const AthleteRankingsScreen({super.key});

  const AthleteRankingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRankings = ref.watch(rankingsProvider);
    final theme = Theme.of(context);
    final mono = theme.extension<AppTextStyles>()!;

    return Column(
      children: [
        const AthleteRankingOptions(),
        const AthleteRankingOptions(),
        Expanded(
          child: asyncRankings.when(
            data: (data) => ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final rankingEntryData = data[index];
                return ListTile(
                  onTap: () => context.push('/athlete/${rankingEntryData.athleteId}'),
                  leading: SizedBox(
                    width: 28,
                    child: Text(
                      '${index + 1}',
                      style: mono.monoMedal.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  title: Text("${rankingEntryData.athleteName} ${rankingEntryData.athleteSurname}"),
                  subtitle: Text("${rankingEntryData.boat} ${rankingEntryData.distance}m - ${CategoryFormatter.formatCategory(rankingEntryData.category)}"),
                  trailing: Text(rankingEntryData.timeLabel, style: mono.monoTime),
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text(err.toString())),
          ),
        ),
      ],
    );
  }
}
