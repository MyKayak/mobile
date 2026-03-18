import '../providers/settings_provider.dart';
import '../models/heat.dart';
import '../utils/requests.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'heats_provider.g.dart';

@riverpod 
Future<List<Heat>> heats(Ref ref, String raceId) async {
  final settings = ref.watch(settingsStateProvider);
  return await getHeats(settings.serverIp, raceId);
}