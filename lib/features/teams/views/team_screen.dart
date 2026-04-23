import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/team_providers.dart';
import '../../../core/utils/time_formatter.dart';

class TeamScreen extends ConsumerWidget {
  final String id;

  const TeamScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamDataAsync = ref.watch(teamProvider(id));

    return Scaffold(
      appBar: teamDataAsync.when(
        data: (teamData) => AppBar(title: Text(teamData.name)),
        loading: () => AppBar(title: const Text("Caricamento...")),
        error: (error, stack) => AppBar(title: const Text("Errore")),
      ),
      body: teamDataAsync.when(
        data: (teamData) => ListView(
          children: [
            Center(child: Text(teamData.name)),
            ...teamData.titles.map(
              (title) => Card(
                child: Column(
                  children: [
                    Text(
                      "${title.boat} ${title.distance}m ${CategoryFormatter.formatDivision(title.division)} ${CategoryFormatter.formatCategory(title.category)}",
                    ),
                    Text("${title.location} ${title.startTime.split("-")[0]}")
                  ],
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => const Center(child: Text("Errore nel caricamento dei dati")),
      ),
    );
  }
}
