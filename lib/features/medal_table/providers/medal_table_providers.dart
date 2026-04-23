import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/medal_table_entry.dart';
import '../../../core/api/api_service_provider.dart';

part 'medal_table_providers.g.dart';

@riverpod
Future<List<MedalTableEntry>> medalTableEntries(Ref ref, String meetId) async {
  final apiService = ref.watch(apiServiceProvider);
  final options = ref.watch(medalTableOptionsStateProvider);
  return await apiService.getMedalTable(meetId, options: options);
}

@riverpod
class MedalTableOptionsState extends _$MedalTableOptionsState {
  @override
  MedalTableOptions build() {
    return const MedalTableOptions(season: 2026);
  }

  void updateSeason(int? season) {
    state = state.copyWith(season: season);
  }

  void updateOnlyChampionships(bool onlyChampionships) {
    state = state.copyWith(onlyChampionships: onlyChampionships);
  }
}
