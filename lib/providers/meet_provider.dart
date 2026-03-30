import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/meet.dart';
import 'api_service_provider.dart';

part 'meet_provider.g.dart';

@riverpod
Future<List<Meet>> meets(Ref ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getMeets();
}