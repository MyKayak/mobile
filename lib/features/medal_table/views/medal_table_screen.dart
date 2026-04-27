import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/medal_table_by_meet.dart';
import '../providers/medal_table_providers.dart';
import '../../../core/widgets/app_card.dart';

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: AppCard(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Stagione:", style: theme.textTheme.bodyMedium),
                      const SizedBox(width: 8),
                      OutlinedButton(
                        onPressed: () {
                          HapticFeedback.selectionClick();
                          _showSeasonSheet(context, ref, options.season);
                        },
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
                      HapticFeedback.lightImpact();
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

  void _showSeasonSheet(BuildContext context, WidgetRef ref, int? currentSeason) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        builder: (context, scrollController) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Seleziona Stagione",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: scrollController,
                children: [2022, 2023, 2024, 2025, 2026, -1].map((year) {
                  return RadioListTile<int>(
                    title: Text(year > 2000 ? year.toString() : "Tutte"),
                    value: year,
                    groupValue: currentSeason ?? -1,
                    onChanged: (value) {
                      HapticFeedback.selectionClick();
                      ref.read(medalTableOptionsStateProvider.notifier).updateSeason(value);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
