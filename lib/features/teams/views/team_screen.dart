import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/team_providers.dart';
import '../../../core/utils/time_formatter.dart';

class TeamScreen extends ConsumerWidget {
  final String id;

  const TeamScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamDataAsync = ref.watch(teamProvider(id));
    final theme = Theme.of(context);
    final mono = theme.extension<AppTextStyles>()!;

    return Scaffold(
      appBar: teamDataAsync.when(
        data: (teamData) => AppBar(title: Text(teamData.name)),
        loading: () => AppBar(title: const Text("Caricamento...")),
        error: (error, stack) => AppBar(title: const Text("Errore")),
      ),
      body: teamDataAsync.when(
        data: (teamData) => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  teamData.name,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ),
            ...teamData.titles.map(
              (title) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${title.boat} ${title.distance}m ${CategoryFormatter.formatDivision(title.division)} ${CategoryFormatter.formatCategory(title.category)}",
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${title.location} ${title.startTime.split("-")[0]}",
                        style: mono.monoDate,
                      ),
                    ],
                  ),
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
