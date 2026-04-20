import 'package:mykayak/core/api/api_service.dart';
import 'package:mykayak/features/athlete_rankings/models/rankings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_service_provider.dart';

part 'ranking_provider.g.dart';

@riverpod
Future<List<RankingEntry>> rankings(Ref ref) async {
    ApiService apiService = ref.watch(apiServiceProvider);
    RankingOptions options = ref.watch(rankingOptionsStateProvider);
    return await apiService.getRankings(options);
}

@riverpod
class RankingOptionsState extends _$RankingOptionsState {
  @override
  RankingOptions build() {
    return const RankingOptions(boat: "K1", category: "M", distance: 500, division: "SEN", season: 2026);
  }

  void updateCategory(String category) {
    state = state.copyWith(category: category);
  }

  void updateBoat(String boat) {
    state = state.copyWith(boat: boat);
  }

  void updateDistance(int distance) {
    state = state.copyWith(distance: distance);
  }

  void updateDivision(String? division) {
    state = state.copyWith(division: division);
  }

  void updateSeason(int? season) {
    state = state.copyWith(season: season);
  }
}
