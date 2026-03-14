import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/components/race_item.dart';
import '../providers/race_provider.dart';

class RacesScreen extends ConsumerWidget {
  final String meetId;
  const RacesScreen({super.key, required this.meetId});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final racesAsync = ref.watch(racesProvider(meetId));

    return Scaffold(
      appBar: AppBar(title: const Text("Gare")),
      body: racesAsync.when(
        data: (races) => ListView.builder(
          itemCount: races.length,
          itemBuilder: (context, index) {
            final race = races[index];
            return RaceItem(
              id: race.id,
              distance: race.distance,
              division: race.division,
              category: race.category,
              boat: race.boat,
              level: race.level
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Errore: $err")),
      ),
    );
  }
}
