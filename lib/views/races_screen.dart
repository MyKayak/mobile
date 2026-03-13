import 'package:flutter/material.dart';
import 'package:mykayak/components/race_item.dart';
import 'package:mykayak/models/race.dart';
import 'package:mykayak/utils/requests.dart';

class RacesScreen extends StatefulWidget {
  String meetId;

  RacesScreen({super.key, required this.meetId});

  @override
  State<RacesScreen> createState() => _RacesScreenState();
}

class _RacesScreenState extends State<RacesScreen> {
  var races = <Race>[];

  void fetchRaces() async {
    races = await getRaces(widget.meetId);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRaces();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) {
          return ListView(
            children: races
                .map(
                  (race) => (RaceItem(
                    id: race.id,
                    distance: race.distance,
                    division: race.division,
                    category: race.category,
                    boat: race.boat,
                    level: race.level
                  )),
                )
                .toList(),
          );
        });
      },
    );
  }
}
