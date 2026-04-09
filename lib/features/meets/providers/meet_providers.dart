import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/meet.dart';
import '../models/race.dart';
import '../models/heat.dart';
import '../models/medal_table_entry.dart';
import '../../../core/api/api_service_provider.dart';

part 'meet_providers.g.dart';

@riverpod
Future<List<Meet>> meets(Ref ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getMeets();
}

@riverpod
Future<List<Race>> races(Ref ref, String meetId) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getRaces(meetId);
}

@riverpod
Future<List<Heat>> heats(Ref ref, String raceId) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getHeats(raceId);
}

@riverpod
Future<List<MedalTableEntry>> medalTableEntries(Ref ref, String meetId) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getMedalTable(meetId);
}
