import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/medal_table_by_meet.dart';
import '../providers/medal_table_providers.dart';

class MedalTableScreen extends ConsumerWidget {
  const MedalTableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final options = ref.watch(medalTableOptionsStateProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Medagliere Generale",
              style: theme.textTheme.titleLarge,
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Stagione:", style: theme.textTheme.bodyMedium),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () => _showSeasonDialog(context, ref, options.season),
                        child: Text(options.season != null && options.season! > 2000 
                            ? options.season.toString() 
                            : "Tutte"),
                      ),
                    ],
                  ),
                  SwitchListTile(
                    title: Text("Solo Campionati", style: theme.textTheme.bodyMedium),
                    value: options.onlyChampionships,
                    onChanged: (value) {
                      ref.read(medalTableOptionsStateProvider.notifier).updateOnlyChampionships(value);
                    },
                  ),
                ],
              ),
            ),
          ),
          const MedalTableByMeet(meetId: '', showHeader: false),
        ],
      ),
    );
  }

  void _showSeasonDialog(BuildContext context, WidgetRef ref, int? currentSeason) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Seleziona Stagione"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [2022, 2023, 2024, 2025, 2026, -1].map((year) {
              return RadioListTile<int>(
                title: Text(year > 2000 ? year.toString() : "Tutte"),
                value: year,
                groupValue: currentSeason ?? -1,
                onChanged: (value) {
                  ref.read(medalTableOptionsStateProvider.notifier).updateSeason(value);
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
