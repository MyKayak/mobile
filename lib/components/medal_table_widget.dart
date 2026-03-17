import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/medal_table_entry_widget.dart';
import '../providers/medal_table_provider.dart';
import 'dart:math';

class MedalTableWidget extends ConsumerWidget {
  final String meetId;

  const MedalTableWidget({super.key, required this.meetId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final medalTableAsync = ref.watch(medalTableEntriesProvider(meetId));

    return medalTableAsync.when(
      data: (medalTable) => Column(children: [
        Text("Medagliere"),
        ...(medalTable.map((medalTableEntry)=>MedalTableEntryWidget(medalTableEntry:medalTableEntry)).toList().sublist(0, min(medalTable.length, 5)))
      ],),
      loading: () => const LinearProgressIndicator(),
      error: (err, stack) => Center(child: Text("Errore medagliere: $err")),
    );
}
  
}