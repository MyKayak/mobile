import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/team_providers.dart';
import 'team_widget.dart';

class TeamSearchWidget extends ConsumerWidget {
  const TeamSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final asyncTeams = ref.watch(teamsProvider(query));

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TextField(
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).update(value);
            },
            decoration: const InputDecoration(
              hintText: 'Canottieri...',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          asyncTeams.when(
            data: (data) => Expanded(
              child: ListView(
                children: data
                    .map((teamPreview) => TeamWidget(teamPreview: teamPreview))
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
