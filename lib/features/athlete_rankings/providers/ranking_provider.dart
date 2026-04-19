import 'package:mykayak/core/api/api_service.dart';
import 'package:mykayak/features/athlete_rankings/models/rankings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_service_provider.dart';

part 'ranking_provider.g.dart';

@riverpod
Future<List<RankingEntry>> rankings(Ref ref, RankingOptions options) async {
    ApiService apiService = ref.watch(apiServiceProvider);
    return await apiService.getRankings(options);
}