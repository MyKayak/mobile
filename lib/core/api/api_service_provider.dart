import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_service.dart';
import '../../features/settings/providers/settings_provider.dart';

part 'api_service_provider.g.dart';

@riverpod
ApiService apiService(Ref ref) {
  final settings = ref.watch(settingsStateProvider);
  return ApiService(serverIp: settings.serverIp);
}
