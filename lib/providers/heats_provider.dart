import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/heat.dart';
import 'api_service_provider.dart';

part 'heats_provider.g.dart';

@riverpod
Future<List<Heat>> heats(Ref ref, String raceId) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getHeats(raceId);
}