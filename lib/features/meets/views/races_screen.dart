import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../medal_table/widgets/medal_table_by_meet.dart';
import '../widgets/race_widget.dart';
import '../providers/meet_providers.dart';

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
              MedalTableByMeet(meetId: meetId, maxItems: 5),
              racesAsync.when(
                data: (races) => Column(
                  children: races
                      .map(
                        (race) => RaceWidget(
                          meetId: meetId,
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
