import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/athlete_providers.dart';
import '../../../core/utils/time_formatter.dart';

class AthleteScreen extends ConsumerWidget {
  final int id;

  const AthleteScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final athleteDataAsync = ref.watch(athleteProvider(id));

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
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            Center(child: Text(athleteData.birthDate)),
            if (athleteData.team != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(athleteData.team!.name),
                ),
              ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Record Personali",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
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
                      width: 120,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "${showBoat ? "${pr.boat[0]} " : ""}${pr.distance}m",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                pr.timeLabel,
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
            if (athleteData.timeProgression.isNotEmpty) ...[
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Progressione Tempi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ...athleteData.timeProgression.entries.map((entry) {
                return ExpansionTile(
                  title: Text(CategoryFormatter.formatTimeProgressionKey(entry.key)),
                  children: entry.value.map((tp) {
                    return ListTile(
                      title: Text(tp.date),
                      trailing: Text(tp.timeLabel),
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
