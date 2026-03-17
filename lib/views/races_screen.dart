import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/components/medal_table_widget.dart';
import 'package:mykayak/components/race_widget.dart';
import '../providers/race_provider.dart';

class RacesScreen extends ConsumerWidget {
  final String meetId;
  const RacesScreen({super.key, required this.meetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final racesAsync = ref.watch(racesProvider(meetId));

    return Scaffold(
      appBar: AppBar(title: const Text("Gare")),
      body: ListView(
        children: [
          Column(
            children: [
              MedalTableWidget(meetId: meetId),
              racesAsync.when(
                data: (races) => Column(
                  children: races
                      .map(
                        (race) => RaceWidget(
                          id: race.id,
                          code: race.code,
                          distance: race.distance,
                          division: race.division,
                          category: race.category,
                          boat: race.boat,
                          level: race.level,
                        ),
                      )
                      .toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Errore: $err")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
