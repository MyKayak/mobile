import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/athlete_providers.dart';

class AthleteScreen extends ConsumerWidget {
  final int id;

  const AthleteScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final athleteDataAsync = ref.watch(athleteProvider(id));

    return Scaffold(
      appBar: athleteDataAsync.when(
        data: (athleteData) => AppBar(title: Text("${athleteData.name} ${athleteData.surname}")),
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
            Center(child: Text("Nato il: ${athleteData.birthDate}")),
            if (athleteData.team != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text("Squadra: ${athleteData.team!.name}"),
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
            ...athleteData.personalRecords.map(
              (pr) => Card(
                child: ListTile(
                  title: Text("${pr.boat} ${pr.distance}m ${pr.category}"),
                  trailing: Text("${pr.time} ms"),
                ),
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
                  title: Text(entry.key.replaceAll('_', ' ')),
                  children: entry.value.map((tp) {
                    return ListTile(
                      title: Text(tp.date),
                      trailing: Text("${tp.timeMs} ms"),
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
