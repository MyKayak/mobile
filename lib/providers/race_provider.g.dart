// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'race_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(races)
final racesProvider = RacesFamily._();

final class RacesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Race>>,
          List<Race>,
          FutureOr<List<Race>>
        >
    with $FutureModifier<List<Race>>, $FutureProvider<List<Race>> {
  RacesProvider._({
    required RacesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'racesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$racesHash();

  @override
  String toString() {
    return r'racesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Race>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Race>> create(Ref ref) {
    final argument = this.argument as String;
    return races(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RacesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$racesHash() => r'90e045c02e42597f2564927b8892c715f51a00a6';

final class RacesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Race>>, String> {
  RacesFamily._()
    : super(
        retry: null,
        name: r'racesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RacesProvider call(String meetId) =>
      RacesProvider._(argument: meetId, from: this);

  @override
  String toString() => r'racesProvider';
}
