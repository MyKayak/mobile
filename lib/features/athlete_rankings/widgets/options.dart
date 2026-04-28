import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/athlete_rankings/models/rankings.dart';
import 'package:mykayak/features/athlete_rankings/providers/ranking_provider.dart';
import '../../../core/widgets/app_card.dart';

class AthleteRankingOptions extends ConsumerWidget {
  const AthleteRankingOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    RankingOptions options = ref.watch(rankingOptionsStateProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AppCard(
        padding: const EdgeInsets.all(12),
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
                    HapticFeedback.lightImpact();
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
                    HapticFeedback.lightImpact();
                    ref.read(rankingOptionsStateProvider.notifier).updateBoat(value.first);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      _showSelectionSheet<int>(
                        context: context,
                        title: "Scegli la distanza",
                        currentValue: options.distance,
                        values: [200, 500, 1000],
                        labelBuilder: (v) => "${v}m",
                        onSelected: (v) => ref.read(rankingOptionsStateProvider.notifier).updateDistance(v),
                      );
                    },
                    child: Text("${options.distance}m"),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      _showSelectionSheet<String?>(
                        context: context,
                        title: "Scegli la categoria",
                        currentValue: options.division,
                        values: ["Tutti", "SEN", "U23", "JUN", "RAG", "RA1"],
                        labelBuilder: (v) => (v == "Tutti" || v == null) ? "Tutte" : v,
                        onSelected: (v) => ref.read(rankingOptionsStateProvider.notifier).updateDivision(v == "Tutti" ? null : v),
                      );
                    },
                    child: Text(options.division ?? "Divisione"),
                  ),
                  const SizedBox(width: 8),
                  OutlinedButton(
                    onPressed: () {
                      HapticFeedback.selectionClick();
                      _showSelectionSheet<int?>(
                        context: context,
                        title: "Scegli la stagione",
                        currentValue: options.season,
                        values: [2022, 2023, 2024, 2025, 2026, -1],
                        labelBuilder: (v) => (v != null && v > 2000) ? v.toString() : "Tutte",
                        onSelected: (v) => ref.read(rankingOptionsStateProvider.notifier).updateSeason(v),
                      );
                    },
                    child: Text(options.season! > 2000 ? options.season!.toString() : "Tutte"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSelectionSheet<T>({
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
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        content: SingleChildScrollView(
          child: RadioGroup<T>(
            groupValue: currentValue,
            onChanged: (newValue) {
              if (newValue != null) {
                HapticFeedback.selectionClick();
                onSelected(newValue);
                Navigator.pop(context);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: values.map((value) {
                return RadioListTile<T>(
                  title: Text(labelBuilder(value)),
                  value: value,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
