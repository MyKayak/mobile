import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/settings.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsState extends _$SettingsState {
  @override
  Settings build() {
    return Settings();
  }

  void updateServerIp(String ip) {
    state = Settings(serverIp: ip);
  }
}
