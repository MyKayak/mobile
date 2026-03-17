import 'package:mykayak/models/medal_table_entry.dart';
import '../providers/settings_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../utils/requests.dart';

part 'medal_table_provider.g.dart';

@riverpod 
Future<List<MedalTableEntry>> medalTableEntries(Ref ref, String meetId) async {
  final settings = ref.watch(settingsStateProvider);
  return await getMedalTable(settings.serverIp, meetId);
}