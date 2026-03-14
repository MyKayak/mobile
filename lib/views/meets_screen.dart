import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/meet_item.dart';
import '../providers/meet_provider.dart';

class MeetsScreen extends ConsumerWidget {
  const MeetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meetsAsync = ref.watch(meetsProvider);

    return meetsAsync.when(
      data: (meets) => ListView.builder(
        itemCount: meets.length,
        itemBuilder: (context, index) {
          final meet = meets[index];
          return MeetItem(
            id: meet.id,
            name: meet.name,
            location: meet.location,
            date: meet.date,
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text("Errore: $err")),
    );
  }
}
