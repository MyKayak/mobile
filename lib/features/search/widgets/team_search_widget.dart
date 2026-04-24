import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../teams/providers/team_providers.dart';
import '../../teams/widgets/team_widget.dart';
import '../../../core/widgets/shimmer.dart';

class TeamSearchWidget extends ConsumerWidget {
  const TeamSearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    final asyncTeams = ref.watch(teamsProvider(query));

    return Column(
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
        Expanded(
          child: asyncTeams.when(
            data: (data) => ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: data
                  .map((teamPreview) => TeamWidget(teamPreview: teamPreview))
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
