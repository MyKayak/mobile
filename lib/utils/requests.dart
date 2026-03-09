import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meet.dart';

Future<List<Meet>> getMeets() async {
  var url = Uri.http('192.168.1.111:8080', "meets"); // TODO: swap with the production domain name
  var response = await http.get(url);
  var meets = <Meet>[];
  jsonDecode(response.body).forEach(
    (map) {meets.add(Meet.fromMap(map));}
  );
  return meets;
}