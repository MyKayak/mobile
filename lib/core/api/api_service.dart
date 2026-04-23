import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mykayak/features/athletes/models/athlete_detail.dart';
import 'package:mykayak/features/athletes/models/athlete_preview.dart';
import 'package:mykayak/features/athlete_rankings/models/rankings.dart';
import 'package:mykayak/features/teams/models/team_detail.dart';
import 'package:mykayak/features/teams/models/team_preview.dart';
import '../../features/meets/models/heat.dart';
import '../../features/meets/models/meet.dart';
import '../../features/meets/models/race.dart';
import '../../features/medal_table/models/medal_table_entry.dart';

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

  Future<T> _getSingle<T>(
    String path,
    T Function(Map<String, dynamic>) fromMap,
  ) async {
    try {
      final url = Uri.parse('$baseUrl/$path');
      final response = await _client.get(url);

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        return fromMap(body as Map<String, dynamic>);
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

  Future<List<MedalTableEntry>> getMedalTable(String meetId, {MedalTableOptions? options}) async {
    String path = 'medal_table?';
    if (meetId.isNotEmpty) {
      path += 'meet_id=$meetId&';
    }
    if (options != null) {
      if (options.season != null && options.season! > 2000) {
        path += "after=${options.season! - 1}-12-31&before=${options.season! + 1}-01-01&";
      }
      if (options.onlyChampionships) {
        path += "only_championships=true&";
      }
    }
    return await _get(
      path,
      (map) => MedalTableEntry.fromMap(map),
    );
  }

  Future<List<Heat>> getHeats(String raceId) async {
    return await _get('heats/$raceId', (map) => Heat.fromMap(map));
  }

  Future<List<TeamPreview>> getTeams(String hint) async  {
    return await _get('teams?hint=$hint', (map) => TeamPreview.fromMap(map));
  }

  Future<List<AthletePreview>> getAthletes(String hint) async  {
    return await _get('athletes?name_hint=$hint', (map) => AthletePreview.fromMap(map));
  }

  Future<TeamDetail> getTeam(String id) async  {
    return await _getSingle('team/$id', (map) => TeamDetail.fromMap(map));
  }

  Future<AthleteDetail> getAthlete(int id) async  {
    return await _getSingle('athlete/${id.toString()}', (map) => AthleteDetail.fromMap(map));
  }

  void dispose() {
    _client.close();
  }

  Future<List<RankingEntry>> getRankings(RankingOptions options) async {
    String path = 'rankings?';
    path += "boat=${options.boat}&";
    path += "distance=${options.distance}&";
    path += "category=${options.category}&";
    path += options.division != null && options.division != "Tutti" ? "division=${options.division}&" : "";
    path += options.season != null && options.season! > 2000 ? "after=${options.season! - 1}-12-31&before=${options.season! + 1}-01-01" : "";

    return await _get(path, (map) => RankingEntry.fromMap(map));
  }
}
