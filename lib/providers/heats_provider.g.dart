// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(heats)
final heatsProvider = HeatsFamily._();

final class HeatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Heat>>,
          List<Heat>,
          FutureOr<List<Heat>>
        >
    with $FutureModifier<List<Heat>>, $FutureProvider<List<Heat>> {
  HeatsProvider._({
    required HeatsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'heatsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$heatsHash();

  @override
  String toString() {
    return r'heatsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Heat>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Heat>> create(Ref ref) {
    final argument = this.argument as String;
    return heats(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HeatsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$heatsHash() => r'25e1dfe8fd32edb579892d4e16bc16c4693aa03f';

final class HeatsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Heat>>, String> {
  HeatsFamily._()
    : super(
        retry: null,
        name: r'heatsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HeatsProvider call(String raceId) =>
      HeatsProvider._(argument: raceId, from: this);

  @override
  String toString() => r'heatsProvider';
}
