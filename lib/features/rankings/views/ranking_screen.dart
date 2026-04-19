import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum RankingType { ranking, medagliere }

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  RankingType mode = RankingType.ranking;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Classifica")),
      body: ListView(
        children: [
          SegmentedButton<RankingType>(
            segments: const [
              ButtonSegment<RankingType>(
                value: RankingType.ranking,
                label: Text('Classifica'),
              ),
              ButtonSegment<RankingType>(
                value: RankingType.medagliere,
                label: Text('Medagliere'),
              ),
            ],
            selected: {mode},
            onSelectionChanged: (Set<RankingType> newSelection) {
              setState(() {
                mode = newSelection.first;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    AlertDialog(title: Text("prova"), content: Text(mode.name),),
              );
            },
          ),
        ],
      ),
    );
  }
}
