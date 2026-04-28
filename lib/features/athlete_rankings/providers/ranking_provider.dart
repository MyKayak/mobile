import 'package:mykayak/features/athlete_rankings/models/rankings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_service_provider.dart';
import '../../../main.dart';

part 'ranking_provider.g.dart';

@riverpod
class Rankings extends _$Rankings {
  @override
  FutureOr<List<RankingEntry>> build() async {
    final options = ref.watch(rankingOptionsStateProvider);
    
    final cached = objectbox.getRankings(options);
    
    if (cached.isNotEmpty) {
      _refreshFromNetwork(options);
      return cached;
    }

    return await _fetchFromNetwork(options);
  }

  Future<List<RankingEntry>> _fetchFromNetwork(RankingOptions options) async {
    final apiService = ref.read(apiServiceProvider);
    final results = await apiService.getRankings(options);
    
    objectbox.saveRankings(options, results);
    return results;
  }

  Future<void> _refreshFromNetwork(RankingOptions options) async {
    try {
      final fresh = await _fetchFromNetwork(options);
      state = AsyncData(fresh);
    } catch (e) {
      // Keep cached data on error
    }
  }
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
