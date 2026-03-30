import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/api_service.dart';
import '../providers/settings_provider.dart';

part 'api_service_provider.g.dart';

@riverpod
ApiService apiService(Ref ref) {
  final settings = ref.watch(settingsStateProvider);
  return ApiService(serverIp: settings.serverIp);
}

