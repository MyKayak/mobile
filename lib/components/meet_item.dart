import 'package:flutter/material.dart';

class MeetItem extends StatefulWidget {
  String id;
  String date;
  String name;
  String location;
  MeetItem({super.key, required this.id, required this.date, required this.name, required this.location});
  @override
  State<MeetItem> createState() => _MeetItemState();
}

class _MeetItemState extends State<MeetItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.location),
              Text(widget.date)
            ],
          ),
          Text(widget.name),
        ],
      ),
    );
  }
}