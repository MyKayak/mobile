import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/heat.dart';
import '../models/meet.dart';
import '../models/race.dart';
import '../models/medal_table_entry.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}

class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({required String serverIp, http.Client? client})
    : baseUrl = 'http://$serverIp',
      _client = client ?? http.Client();

  Future<List<T>> _get<T>(
    String path,
    T Function(Map<String, dynamic>) fromMap,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/$path');
      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        return body
            .map((item) => fromMap(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          'Request failed: ${response.reasonPhrase}',
          statusCode: response.statusCode,
        );
      }
    } on http.ClientException catch (e) {
      throw ApiException('Network error: ${e.message}');
    } on FormatException catch (e) {
      throw ApiException('Invalid response format: ${e.message}');
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException('Unexpected error: $e');
    }
  }

  Future<List<Meet>> getMeets() async {
    return await _get('meets', (map) => Meet.fromMap(map));
  }

  Future<List<Race>> getRaces(String meetId) async {
    return await _get('races/$meetId', (map) => Race.fromMap(map));
  }

  Future<List<MedalTableEntry>> getMedalTable(String meetId) async {
    return await _get(
      'medal_table/$meetId',
      (map) => MedalTableEntry.fromMap(map),
    );
  }

  Future<List<Heat>> getHeats(String raceId) async {
    return await _get('heats/$raceId', (map) => Heat.fromMap(map));
  }

  void dispose() {
    _client.close();
  }
}
