import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/team_providers.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../core/widgets/shimmer.dart';
import '../../../core/widgets/app_card.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Titoli",
                style: theme.textTheme.titleMedium,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 84,
              ),
              itemCount: teamData.titles.length,
              itemBuilder: (context, index) {
                final title = teamData.titles[index];
                return AppCard(
                  margin: EdgeInsets.zero,
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${title.boat} ${title.distance}m ${CategoryFormatter.formatDivision(title.division)} ${CategoryFormatter.formatCategory(title.category)}",
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${title.location} ${title.startTime.split("-")[0]}",
                        style: mono.monoDate.copyWith(fontSize: 11),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        loading: () => Shimmer(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: SkeletonBox(width: 250, height: 28)),
                const SizedBox(height: 32),
                const SkeletonBox(width: 100, height: 20),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 84,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) => const SkeletonBox(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
        error: (error, stack) => const Center(child: Text("Errore nel caricamento dei dati")),
      ),
    );
  }
}
