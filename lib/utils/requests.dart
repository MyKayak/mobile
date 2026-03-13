import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mykayak/models/race.dart';
import '../models/meet.dart';

Future<List<Meet>> getMeets() async {
  var url = Uri.http('localhost:8080', "meets"); // TODO: swap with the production domain name
  var response = await http.get(url);
  var meets = <Meet>[];
  jsonDecode(response.body).forEach(
    (map) {meets.add(Meet.fromMap(map));}
  );
  return meets;
}

Future<List<Race>> getRaces(String id) async {
  var url = Uri.http('localhost:8080', "races/$id"); // TODO: swap with the production domain name
  var response = await http.get(url);
  var races = <Race>[];
  jsonDecode(response.body).forEach(
    (map) {races.add(Race.fromMap(map));}
  );
  return races;
}