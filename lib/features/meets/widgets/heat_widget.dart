import 'package:flutter/material.dart';
import '../models/heat.dart';

class HeatWidget extends StatelessWidget {
  final Heat heat;

  HeatWidget({super.key, required this.heat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Batteria ${heat.index}",
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
              Text(heat.startTime.split(" ")[1]),
            ],
          ),
          ...heat.performances.map(
            (performance) => (Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(performance.placement.toString()),
                    Text("(${performance.lane})"),
                  ],
                ),
                Column(
                  children: [
                    ...performance.athletes.map(
                      (athlete) => Text(
                        "${athlete.name} ${athlete.surname} ",
                      ),
                    ),
                  ],
                ),
                Text(performance.teamName),
                Text(
                  performance.status.isEmpty
                      ? performance.timeLabel
                      : performance.status,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
