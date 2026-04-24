import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/athlete_providers.dart';
import '../../../core/utils/time_formatter.dart';

class AthleteScreen extends ConsumerWidget {
  final int id;

  const AthleteScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final athleteDataAsync = ref.watch(athleteProvider(id));
    final theme = Theme.of(context);
    final mono = theme.extension<AppTextStyles>()!;

    return Scaffold(
      appBar: athleteDataAsync.when(
        data: (athleteData) =>
            AppBar(title: Text("${athleteData.name} ${athleteData.surname}")),
        loading: () => AppBar(title: const Text("Caricamento...")),
        error: (error, stack) => AppBar(title: const Text("Errore")),
      ),
      body: athleteDataAsync.when(
        data: (athleteData) => ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${athleteData.name} ${athleteData.surname}",
                  style: theme.textTheme.headlineSmall,
                ),
              ),
            ),
            Center(child: Text(athleteData.birthDate, style: mono.monoDate)),
            if (athleteData.team != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    athleteData.team!.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Record Personali",
                style: theme.textTheme.titleMedium,
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth - 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (() {
                        final filteredPRs = athleteData.personalRecords
                            .where((pr) => pr.boat.endsWith("1"))
                            .toList();
                        
                        filteredPRs.sort((a, b) {
                          int distComp = a.distance.compareTo(b.distance);
                          if (distComp != 0) return distComp;
                          return a.boat.compareTo(b.boat);
                        });

                        final uniqueBoats = filteredPRs
                            .map((pr) => pr.boat[0].toUpperCase())
                            .toSet();
                        final showBoat = uniqueBoats.length > 1;

                        return filteredPRs.map(
                          (pr) => SizedBox(
                            width: 148,
                            child: Card(
                              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "${showBoat ? "${pr.boat[0]} " : ""}${pr.distance}m",
                                      style: theme.textTheme.titleSmall,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      pr.timeLabel,
                                      style: mono.monoTime,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ).toList();
                      })(),
                    ),
                  ),
                );
              },
            ),
            if (athleteData.timeProgression.isNotEmpty) ...[
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Progressione Tempi",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              ...athleteData.timeProgression.entries.map((entry) {
                return ExpansionTile(
                  title: Text(CategoryFormatter.formatTimeProgressionKey(entry.key)),
                  children: entry.value.map((tp) {
                    return ListTile(
                      title: Text(tp.date, style: mono.monoDate),
                      trailing: Text(tp.timeLabel, style: mono.monoTime),
                    );
                  }).toList(),
                );
              }),
            ],
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
