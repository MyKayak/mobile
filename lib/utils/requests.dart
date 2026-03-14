import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mykayak/models/race.dart';
import '../models/meet.dart';

Future<List<Meet>> getMeets(String serverIp) async {
  var url = Uri.http(serverIp, "meets"); 
  var response = await http.get(url);
  var meets = <Meet>[];
  jsonDecode(response.body).forEach(
    (map) {meets.add(Meet.fromMap(map));}
  );
  return meets;
}

Future<List<Race>> getRaces(String serverIp, String id) async {
  var url = Uri.http(serverIp, "races/$id");
  var response = await http.get(url);
  var races = <Race>[];
  jsonDecode(response.body).forEach(
    (map) {races.add(Race.fromMap(map));}
  );
  return races;
}