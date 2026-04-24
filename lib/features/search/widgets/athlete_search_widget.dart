import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../athletes/providers/athlete_providers.dart';
import '../../athletes/widgets/athlete_widget.dart';

class AthleteSearchWidget extends ConsumerWidget {
  const AthleteSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final asyncAthletes = ref.watch(athletesProvider(query));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              if(value.length < 3) return;
              ref.read(searchQueryProvider.notifier).update(value);
            },
            decoration: const InputDecoration(
              hintText: 'Daniele Sc...',
              prefixIcon: Icon(Icons.person_search),
            ),
          ),
          const SizedBox(height: 10),
          asyncAthletes.when(
            data: (data) => Expanded(
              child: ListView(
                children: data
                    .map((athletePreview) => AthleteWidget(athletePreview: athletePreview))
                    .toList(),
              ),
            ),
            error: (err, stack) => Center(child: Text(err.toString())),
            loading: () => const Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
