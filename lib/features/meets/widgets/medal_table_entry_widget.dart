import 'package:flutter/material.dart';
import '../models/medal_table_entry.dart';

class MedalTableEntryWidget extends StatelessWidget {
  final MedalTableEntry medalTableEntry;

  const MedalTableEntryWidget({super.key, required this.medalTableEntry});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text(medalTableEntry.teamName),
      Row(children: [
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Text(medalTableEntry.golds.toString())
          )
        ),
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Text(medalTableEntry.silvers.toString())
          )
        ),
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Text(medalTableEntry.bronzes.toString())
          )
        ),
        DecoratedBox(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            width: 20,
            height: 20,
            child: Text(medalTableEntry.total.toString())
          )
        )
      ],),
    ]);
  }
}
