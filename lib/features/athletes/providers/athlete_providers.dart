import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_service_provider.dart';
import '../models/athlete_detail.dart';
import '../models/athlete_preview.dart';

part 'athlete_providers.g.dart';

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

@riverpod
Future<List<AthletePreview>> athletes(Ref ref, String hint) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getAthletes(hint);
}

@riverpod
Future<AthleteDetail> athlete(Ref ref, int id) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getAthlete(id);
}