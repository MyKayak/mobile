import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/athlete_rankings/providers/ranking_provider.dart';
import 'package:mykayak/features/athlete_rankings/widgets/options.dart';

class AthleteRankingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncRankings = ref.watch(rankingsProvider);

    return Column(
      children: [
        AthleteRankingOptions(),
        Expanded(
          child: asyncRankings.when(
            data: (data) => ListView(
              children: data
                  .map((rankingEntryData) => ListTile(
                        title: Text("${rankingEntryData.athleteName} ${rankingEntryData.athleteSurname}"),
                        subtitle: Text("${rankingEntryData.boat} ${rankingEntryData.distance}m - ${rankingEntryData.category}"),
                        trailing: Text("${rankingEntryData.bestTime}s"),
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
