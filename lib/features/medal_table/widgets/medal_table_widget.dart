import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/medal_badge.dart';
import '../../../core/widgets/app_card.dart';
import '../models/medal_table_entry.dart';
import 'dart:math';

class MedalTableWidget extends ConsumerWidget {
  final List<MedalTableEntry> medalTableEntries;
  final int? maxItems;
  final bool showHeader;

  const MedalTableWidget({
    super.key,
    required this.medalTableEntries,
    this.maxItems,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final entries = maxItems != null
        ? medalTableEntries.sublist(0, min(medalTableEntries.length, maxItems!))
        : medalTableEntries;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Medagliere",
                style: theme.textTheme.titleMedium,
              ),
            ),
          Column(
            children: [
              if (showHeader)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text("Società", style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant))),
                      SizedBox(width: 44, child: Center(child: Text("O", style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)))),
                      SizedBox(width: 44, child: Center(child: Text("A", style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)))),
                      SizedBox(width: 44, child: Center(child: Text("B", style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)))),
                      SizedBox(width: 44, child: Center(child: Text("Tot", style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)))),
                    ],
                  ),
                ),
              ...entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: AppCard(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        context.push('/team/${entry.teamId}');
                      },
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.teamName,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(width: 44, child: MedalBadge.gold(entry.golds)),
                          SizedBox(width: 44, child: MedalBadge.silver(entry.silvers)),
                          SizedBox(width: 44, child: MedalBadge.bronze(entry.bronzes)),
                          SizedBox(width: 44, child: MedalBadge.total(entry.total)),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

