import 'package:mykayak/models/medal_table_entry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_service_provider.dart';

part 'medal_table_provider.g.dart';

@riverpod
Future<List<MedalTableEntry>> medalTableEntries(Ref ref, String meetId) async {
  final apiService = ref.watch(apiServiceProvider);
  return await apiService.getMedalTable(meetId);
}