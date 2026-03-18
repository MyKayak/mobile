import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mykayak/models/medal_table_entry.dart';
import 'package:mykayak/models/race.dart';
import '../models/heat.dart';
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

Future<List<MedalTableEntry>> getMedalTable(String serverIp, String id) async {
  var url = Uri.http(serverIp, "medal_table/$id");
  var response = await http.get(url);
  var entries = <MedalTableEntry>[];
  jsonDecode(response.body).forEach(
    (map) {entries.add(MedalTableEntry.fromMap(map));}
  );
  return entries;
}

Future<List<Heat>> getHeats(String serverIp, String id) async {
  var url = Uri.http(serverIp, "heats/$id");
  var response = await http.get(url);
  var heats = <Heat>[];
  jsonDecode(response.body).forEach(
    (map) {heats.add(Heat.fromMap(map));}
  );
  return heats;
}