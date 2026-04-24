import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/meet_providers.dart';
import '../widgets/heat_widget.dart';

class HeatsScreen extends ConsumerWidget {
  final int raceId;
  const HeatsScreen({super.key, required this.raceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heatsAsync = ref.watch(heatsProvider(raceId.toString()));

    return Scaffold(
      appBar: AppBar(title: const Text("Batterie")),
      body: heatsAsync.when(
        data: (heats) => ListView(
          children: [
            ...heats.map((heat) => HeatWidget(heat: heat)),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Errore: $err"),
          ),
        ),
      ),
    );
  }
}
