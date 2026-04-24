import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/features/settings/widgets/settings_button.dart';
import '../widgets/meet_widget.dart';
import '../providers/meet_providers.dart';

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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Errore: $err")),
      ),
    );
  }
}
