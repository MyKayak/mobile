import 'package:mykayak/main.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/settings.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsState extends _$SettingsState {
  @override
  Settings build() {
    var settings = objectbox.settingsBox.get(1);

    if (settings == null) {
      objectbox.settingsBox.put(Settings());
      settings = objectbox.settingsBox.get(1);
    }

    return settings ?? Settings();
  }

  void updateServerIp(String ip) {
    state.id = 1;
    state.serverIp = ip;

    objectbox.settingsBox.put(state);

    state = state;
  }
}
