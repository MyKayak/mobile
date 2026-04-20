import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/athlete_rankings/models/rankings.dart';
import 'package:mykayak/features/athlete_rankings/providers/ranking_provider.dart';

class AthleteRankingOptions extends ConsumerWidget {
  const AthleteRankingOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RankingOptions options = ref.watch(rankingOptionsStateProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: "M", label: Text("M")),
                    ButtonSegment(value: "F", label: Text("F")),
                  ],
                  selected: {options.category},
                  onSelectionChanged: (value) {
                    ref.read(rankingOptionsStateProvider.notifier).updateCategory(value.first);
                  },
                ),
                const SizedBox(width: 10),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: "K1", label: Text("K1")),
                    ButtonSegment(value: "C1", label: Text("C1")),
                  ],
                  selected: {options.boat},
                  onSelectionChanged: (value) {
                    ref.read(rankingOptionsStateProvider.notifier).updateBoat(value.first);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => _showSelectionDialog<int>(
                    context: context,
                    title: "Select Distance",
                    currentValue: options.distance,
                    values: [200, 500, 1000, 5000],
                    labelBuilder: (v) => "${v}m",
                    onSelected: (v) => ref.read(rankingOptionsStateProvider.notifier).updateDistance(v),
                  ),
                  child: Text("${options.distance}m"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () => _showSelectionDialog<String?>(
                    context: context,
                    title: "Select Division",
                    currentValue: options.division,
                    values: ["Tutti", "SEN", "U23", "JUN", "RAG", "RA1"],
                    labelBuilder: (v) => v ?? "Tutti",
                    onSelected: (v) => ref.read(rankingOptionsStateProvider.notifier).updateDivision(v),
                  ),
                  child: Text(options.division ?? "Division"),
                ),
                const SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () => _showSelectionDialog<int?>(
                    context: context,
                    title: "Select Season",
                    currentValue: options.season,
                    values: [2022, 2023, 2024, 2025, 2026, -1],
                    labelBuilder: (v) => v! > 2000 ? v.toString() : "Tutte",
                    onSelected: (v) => ref.read(rankingOptionsStateProvider.notifier).updateSeason(v),
                  ),
                  child: Text(options.season! > 2000 ? options.season!.toString() : "Tutte"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectionDialog<T>({
    required BuildContext context,
    required String title,
    required T currentValue,
    required List<T> values,
    required String Function(T) labelBuilder,
    required void Function(T) onSelected,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: values.map((value) {
              return RadioListTile<T>(
                title: Text(labelBuilder(value)),
                value: value,
                groupValue: currentValue,
                onChanged: (newValue) {
                  onSelected(value);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
