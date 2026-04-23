import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final entries = maxItems != null
        ? medalTableEntries.sublist(0, min(medalTableEntries.length, maxItems!))
        : medalTableEntries;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Medagliere",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          Column(
            children: [
              if (showHeader)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(child: Text("Società", style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(width: 44, child: Center(child: Text("O", style: TextStyle(fontWeight: FontWeight.bold)))),
                      SizedBox(width: 44, child: Center(child: Text("A", style: TextStyle(fontWeight: FontWeight.bold)))),
                      SizedBox(width: 44, child: Center(child: Text("B", style: TextStyle(fontWeight: FontWeight.bold)))),
                      SizedBox(width: 44, child: Center(child: Text("Tot", style: TextStyle(fontWeight: FontWeight.bold)))),
                    ],
                  ),
                ),
              ...entries.map((entry) => InkWell(
                    onTap: () => context.push('/team/${entry.teamId}'),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(entry.teamName, overflow: TextOverflow.ellipsis),
                          ),
                          SizedBox(width: 44, child: _MedalCell(count: entry.golds, color: const Color(0xFFFFD700))),
                          SizedBox(width: 44, child: _MedalCell(count: entry.silvers, color: const Color(0xFFC0C0C0))),
                          SizedBox(width: 44, child: _MedalCell(count: entry.bronzes, color: const Color(0xFFCD7F32))),
                          SizedBox(width: 44, child: _MedalCell(count: entry.total, color: Colors.white, isTotal: true)),
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
    final countStr = count.toString();
    return Center(
      child: Container(
        margin: const EdgeInsets.all(2),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color.withOpacity(0.9),
          shape: BoxShape.circle,
          border: !isTotal ? Border.all(color: Colors.black26, width: 1.5) : Border.all(color: Colors.black12, width: 1),
          boxShadow: [
            if (!isTotal)
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          countStr,
          style: TextStyle(
            fontSize: countStr.length > 2 ? 10 : 12,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
