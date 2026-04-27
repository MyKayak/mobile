import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../medal_table/widgets/medal_table_by_meet.dart';
import '../widgets/race_widget.dart';
import '../providers/meet_providers.dart';
import '../../../core/widgets/shimmer.dart';

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
              const SizedBox(height: 8),
              racesAsync.when(
                data: (races) => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                loading: () => Shimmer(
                  child: Column(
                    children: List.generate(
                      8,
                      (index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: SkeletonBox(width: double.infinity, height: 44, borderRadius: 16),
                      ),
                    ),
                  ),
                ),
                error: (err, stack) => Center(child: Text("Errore: $err")),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
