import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/athlete_rankings/providers/ranking_provider.dart';
import 'package:mykayak/features/athlete_rankings/widgets/options.dart';
import 'package:mykayak/core/utils/time_formatter.dart';

class AthleteRankingsScreen extends ConsumerWidget {
  const AthleteRankingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRankings = ref.watch(rankingsProvider);

    return Column(
      children: [
        const AthleteRankingOptions(),
        Expanded(
          child: asyncRankings.when(
            data: (data) => ListView(
              children: data
                  .map((rankingEntryData) => ListTile(
                        onTap: () => context.push('/athlete/${rankingEntryData.athleteId}'),
                        title: Text("${rankingEntryData.athleteName} ${rankingEntryData.athleteSurname}"),
                        subtitle: Text("${rankingEntryData.boat} ${rankingEntryData.distance}m - ${CategoryFormatter.formatCategory(rankingEntryData.category)}"),
                        trailing: Text(rankingEntryData.timeLabel),
                      ))
                  .toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text(err.toString())),
          ),
        ),
      ],
    );
  }
}
