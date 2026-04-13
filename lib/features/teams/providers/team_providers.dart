import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/api/api_service_provider.dart';
import '../models/team_preview.dart';

part 'team_providers.g.dart';

@riverpod
class searchQuery extends _$searchQuery {
  @override
  String build() => '';

  void update(String query) => state = query;
}

@riverpod
Future<List<TeamPreview>> teams(Ref ref, String hint) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getTeams(hint);
}

