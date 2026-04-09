import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MeetWidget extends StatelessWidget {
  final String id;
  final String date;
  final String name;
  final String location;
  const MeetWidget({super.key, required this.id, required this.date, required this.name, required this.location});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10
      ),
      child: InkWell(
        onTap: () {
          context.push('/meets/races/$id');
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(location, style:TextStyle(fontSize:18), overflow: TextOverflow.ellipsis,),
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
