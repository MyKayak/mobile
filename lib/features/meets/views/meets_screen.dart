import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/settings/widgets/settings_button.dart';
import '../widgets/meet_widget.dart';
import '../providers/meet_providers.dart';
import '../../../core/widgets/shimmer.dart';

class MeetsScreen extends ConsumerWidget {
  const MeetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetsAsync = ref.watch(meetsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gare e Risultati"),
        actions: const [SettingsButton()],
      ),
      body: meetsAsync.when(
        data: (meets) => ListView.builder(
          itemCount: meets.length,
          itemBuilder: (context, index) {
            final meet = meets[index];
            return MeetWidget(
              id: meet.id,
              name: meet.name,
              location: meet.location,
              date: meet.date,
            );
          },
        ),
        loading: () => Shimmer(
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonBox(width: 160, height: 18),
                      SkeletonBox(width: 70, height: 14),
                    ],
                  ),
                  SizedBox(height: 8),
                  SkeletonBox(width: 240, height: 14),
                ],
              ),
            ),
          ),
        ),
        error: (err, stack) => Center(child: Text("Errore: $err")),
      ),
    );
  }
}
