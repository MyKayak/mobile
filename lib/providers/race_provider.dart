import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../utils/requests.dart';
import '../models/race.dart';
import 'settings_provider.dart';

part 'race_provider.g.dart';

@riverpod 
Future<List<Race>> races(Ref ref, String meetId) async {
  final settings = ref.watch(settingsStateProvider);
  return await getRaces(settings.serverIp, meetId);
}