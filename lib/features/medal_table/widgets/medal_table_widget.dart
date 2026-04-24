import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
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
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Medagliere",
                style: theme.textTheme.titleMedium,
              ),
            ),
          Column(
            children: [
              if (showHeader)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text("Società", style: theme.textTheme.titleSmall)),
                      SizedBox(width: 44, child: Center(child: Text("O", style: theme.textTheme.titleSmall))),
                      SizedBox(width: 44, child: Center(child: Text("A", style: theme.textTheme.titleSmall))),
                      SizedBox(width: 44, child: Center(child: Text("B", style: theme.textTheme.titleSmall))),
                      SizedBox(width: 44, child: Center(child: Text("Tot", style: theme.textTheme.titleSmall))),
                    ],
                  ),
                ),
              ...entries.map((entry) => InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () => context.push('/team/${entry.teamId}'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.teamName,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(width: 44, child: _MedalCell(count: entry.golds, color: AppColors.gold)),
                          SizedBox(width: 44, child: _MedalCell(count: entry.silvers, color: AppColors.silver)),
                          SizedBox(width: 44, child: _MedalCell(count: entry.bronzes, color: AppColors.bronze)),
                          SizedBox(width: 44, child: _MedalCell(count: entry.total, color: theme.colorScheme.surfaceContainerHighest, isTotal: true)),
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

class _MedalCell extends StatelessWidget {
  final int count;
  final Color color;
  final bool isTotal;

  const _MedalCell({
    required this.count,
    required this.color,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final mono = Theme.of(context).extension<AppTextStyles>()!;
    final countStr = count.toString();
    return Center(
      child: Container(
        margin: const EdgeInsets.all(2),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withAlpha(230),
          shape: BoxShape.circle,
          border: !isTotal
              ? Border.all(color: color.withAlpha(180), width: 1.5)
              : Border.all(color: AppColors.outline, width: 1),
          boxShadow: [
            if (!isTotal)
              BoxShadow(
                color: color.withAlpha(40),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          countStr,
          style: mono.monoMedal.copyWith(
            fontSize: countStr.length > 2 ? 10 : 12,
            color: isTotal ? AppColors.onSurface : Colors.black87,
          ),
        ),
      ),
    );
  }
}
