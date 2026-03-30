import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/race.dart';
import 'api_service_provider.dart';

part 'race_provider.g.dart';

@riverpod
Future<List<Race>> races(Ref ref, String meetId) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getRaces(meetId);
}