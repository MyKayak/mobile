// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medal_table_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(medalTableEntries)
final medalTableEntriesProvider = MedalTableEntriesFamily._();

final class MedalTableEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MedalTableEntry>>,
          List<MedalTableEntry>,
          FutureOr<List<MedalTableEntry>>
        >
    with
        $FutureModifier<List<MedalTableEntry>>,
        $FutureProvider<List<MedalTableEntry>> {
  MedalTableEntriesProvider._({
    required MedalTableEntriesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'medalTableEntriesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$medalTableEntriesHash();

  @override
  String toString() {
    return r'medalTableEntriesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MedalTableEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MedalTableEntry>> create(Ref ref) {
    final argument = this.argument as String;
    return medalTableEntries(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MedalTableEntriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$medalTableEntriesHash() => r'1a3cae12412cc391980b9f6af708dede2d389392';

final class MedalTableEntriesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MedalTableEntry>>, String> {
  MedalTableEntriesFamily._()
    : super(
        retry: null,
        name: r'medalTableEntriesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MedalTableEntriesProvider call(String meetId) =>
      MedalTableEntriesProvider._(argument: meetId, from: this);

  @override
  String toString() => r'medalTableEntriesProvider';
}
