import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mykayak/providers/heats_provider.dart';

import '../components/heat_widget.dart';

class HeatsScreen extends ConsumerWidget {
  final int raceId;
  const HeatsScreen({super.key, required this.raceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heatsAsync = ref.watch(heatsProvider(raceId.toString()));

    return Scaffold(
      appBar: AppBar(title: Text("Batterie")),
      body: heatsAsync.when(
        data: (heats) =>ListView(children:[Column(children: [...heats.map((heat) => HeatWidget(heat: heat))]),]),
            
        loading: () => Center(child:CircularProgressIndicator()),
        error: (err, stack) => Text("Errore:$err\nDove:$stack"),
      ),
    );
  }
}
