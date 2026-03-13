import 'package:flutter/material.dart';

class RaceItem extends StatelessWidget {
  final String id;
  final int distance;
  final String division;
  final String category;
  final String boat;
  final String level;
  const RaceItem({super.key, required this.id, required this.distance, required this.division, required this.category, required this.boat, required this.level});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10
      ),
      child: ElevatedButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RacesScreen(),
          ));
        },
        style: ButtonStyle(
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(location, style:TextStyle(fontSize:18)),
                Text(date, style:TextStyle(fontSize:18))
              ],
            ),
            Text(name, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color.fromARGB(128, 0, 0, 0), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}