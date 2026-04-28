import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/athlete_providers.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../core/widgets/shimmer.dart';
import '../../../core/widgets/app_card.dart';
import '../widgets/time_progression_chart.dart';

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
                            child: AppCard(
                              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                  children: [
                    TimeProgressionChart(entries: entry.value),
                    ...entry.value.map((tp) {
                      return ListTile(
                        title: Text(tp.date, style: mono.monoDate),
                        trailing: Text(tp.timeLabel, style: mono.monoTime),
                      );
                    }),
                  ],
                );
              }),
            ],
          ],
        ),
        loading: () => const Shimmer(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SkeletonBox(width: 200, height: 28),
                SizedBox(height: 8),
                SkeletonBox(width: 120, height: 16),
                SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SkeletonBox(width: 150, height: 20),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SkeletonBox(width: 140, height: 70, borderRadius: 16),
                    SizedBox(width: 8),
                    SkeletonBox(width: 140, height: 70, borderRadius: 16),
                  ],
                ),
                SizedBox(height: 32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SkeletonBox(width: 180, height: 20),
                ),
                SizedBox(height: 16),
                SkeletonBox(width: double.infinity, height: 50, borderRadius: 8),
              ],
            ),
          ),
        ),
        error: (error, stack) => Center(child: Text(error.toString())),
      ),
    );
  }
}
