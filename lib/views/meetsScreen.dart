import 'package:flutter/material.dart';
import '../utils/requests.dart';
import '../models/meet.dart';
class MeetsScreen extends StatefulWidget {
  @override
  State<MeetsScreen> createState() => _MeetsScreenState();
}

class _MeetsScreenState extends State<MeetsScreen> {
  var meets = <Meet>[];

  void fetchMeets() async {
    meets = await getMeets();
    setState((){
      meets = meets;
    });
  }

  @override
  void initState() {
    fetchMeets();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: meets.map((meet)=>(Text(meet.location))).toList(),
    );
  }
}