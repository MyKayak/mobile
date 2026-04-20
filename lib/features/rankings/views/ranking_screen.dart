import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/athlete_rankings/views/athlete_rankings_screen.dart';
import 'package:mykayak/features/medal_table/views/medal_table_screen.dart';

enum RankingType { ranking, medalTable }

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  RankingType mode = RankingType.ranking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Classifica")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SegmentedButton<RankingType>(
              segments: const [
                ButtonSegment<RankingType>(
                  value: RankingType.ranking,
                  label: Text('Classifica'),
                ),
                ButtonSegment<RankingType>(
                  value: RankingType.medalTable,
                  label: Text('Medagliere'),
                ),
              ],
              selected: {mode},
              onSelectionChanged: (Set<RankingType> newSelection) {
                setState(() {
                  mode = newSelection.first;
                });
              },
            ),
          ),
          Expanded(
            child: mode == RankingType.ranking
                ? AthleteRankingsScreen()
                : MedalTableScreen(),
          ),
        ],
      ),
    );
  }
}
