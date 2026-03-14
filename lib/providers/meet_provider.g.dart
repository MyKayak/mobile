// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meet_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(meets)
final meetsProvider = MeetsProvider._();

final class MeetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Meet>>,
          List<Meet>,
          FutureOr<List<Meet>>
        >
    with $FutureModifier<List<Meet>>, $FutureProvider<List<Meet>> {
  MeetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'meetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$meetsHash();

  @$internal
  @override
  $FutureProviderElement<List<Meet>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Meet>> create(Ref ref) {
    return meets(ref);
  }
}

String _$meetsHash() => r'6ca8679246d5c3716c42d5d692ded88295c62fa9';
