import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../teams/providers/team_providers.dart';
import '../../teams/widgets/team_widget.dart';

class TeamSearchWidget extends ConsumerWidget {
  const TeamSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final asyncTeams = ref.watch(teamsProvider(query));

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
              hintText: 'Canottieri...',
              prefixIcon: Icon(Icons.groups_outlined),
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
