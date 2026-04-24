import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../athletes/providers/athlete_providers.dart';
import '../../athletes/widgets/athlete_widget.dart';
import '../../../core/widgets/shimmer.dart';

class AthleteSearchWidget extends ConsumerWidget {
  const AthleteSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final asyncAthletes = ref.watch(athletesProvider(query));

    return Column(
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
        Expanded(
          child: asyncAthletes.when(
            data: (data) => ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: data
                  .map((athletePreview) => AthleteWidget(athletePreview: athletePreview))
                  .toList(),
            ),
            error: (err, stack) => Center(child: Text(err.toString())),
            loading: () => Shimmer(
              child: ListView.builder(
                itemCount: 10,
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SkeletonBox(width: double.infinity, height: 50, borderRadius: 16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
