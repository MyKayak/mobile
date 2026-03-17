// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SettingsState)
final settingsStateProvider = SettingsStateProvider._();

final class SettingsStateProvider
    extends $NotifierProvider<SettingsState, Settings> {
  SettingsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsStateHash();

  @$internal
  @override
  SettingsState create() => SettingsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Settings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Settings>(value),
    );
  }
}

String _$settingsStateHash() => r'62340f823a59ee052de8a0cc94ba3b5ec4b80f45';

abstract class _$SettingsState extends $Notifier<Settings> {
  Settings build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Settings, Settings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Settings, Settings>,
              Settings,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
