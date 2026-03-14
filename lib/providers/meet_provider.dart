import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../utils/requests.dart';
import '../models/meet.dart';
import 'settings_provider.dart';

part 'meet_provider.g.dart';

@riverpod 
Future<List<Meet>> meets(Ref ref) async {
  final settings = ref.watch(settingsStateProvider);
  return await getMeets(settings.serverIp);
}