import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/medal_table_providers.dart';
import 'medal_table_widget.dart';

class MedalTableByMeet extends ConsumerWidget {
  final String meetId;
  final int? maxItems;
  final bool showHeader;

  const MedalTableByMeet({
    super.key,
    required this.meetId,
    this.maxItems,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medalTableAsync = ref.watch(medalTableEntriesProvider(meetId));

    return medalTableAsync.when(
      data: (medalTable) => MedalTableWidget(
        medalTableEntries: medalTable,
        maxItems: maxItems,
        showHeader: showHeader,
      ),
      loading: () => const Center(child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircularProgressIndicator(),
      )),
      error: (err, stack) => Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Errore caricamento medagliere: $err"),
        ),
      ),
    );
  }
}
