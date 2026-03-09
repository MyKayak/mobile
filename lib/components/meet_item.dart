import 'package:flutter/material.dart';

class MeetItem extends StatelessWidget {
  final String id;
  final String date;
  final String name;
  final String location;
  const MeetItem({super.key, required this.id, required this.date, required this.name, required this.location});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
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
    );
  }
}