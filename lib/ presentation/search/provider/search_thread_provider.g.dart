// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_thread_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchThreadHash() => r'624fa0a29f69ee1ee67917169c705ca8398c41b4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SearchThread
    extends BuildlessAutoDisposeAsyncNotifier<List<Post>> {
  late final String queryString;

  FutureOr<List<Post>> build(
    String queryString,
  );
}

/// See also [SearchThread].
@ProviderFor(SearchThread)
const searchThreadProvider = SearchThreadFamily();

/// See also [SearchThread].
class SearchThreadFamily extends Family<AsyncValue<List<Post>>> {
  /// See also [SearchThread].
  const SearchThreadFamily();

  /// See also [SearchThread].
  SearchThreadProvider call(
    String queryString,
  ) {
    return SearchThreadProvider(
      queryString,
    );
  }

  @override
  SearchThreadProvider getProviderOverride(
    covariant SearchThreadProvider provider,
  ) {
    return call(
      provider.queryString,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'searchThreadProvider';
}

/// See also [SearchThread].
class SearchThreadProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SearchThread, List<Post>> {
  /// See also [SearchThread].
  SearchThreadProvider(
    String queryString,
  ) : this._internal(
          () => SearchThread()..queryString = queryString,
          from: searchThreadProvider,
          name: r'searchThreadProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchThreadHash,
          dependencies: SearchThreadFamily._dependencies,
          allTransitiveDependencies:
              SearchThreadFamily._allTransitiveDependencies,
          queryString: queryString,
        );

  SearchThreadProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.queryString,
  }) : super.internal();

  final String queryString;

  @override
  FutureOr<List<Post>> runNotifierBuild(
    covariant SearchThread notifier,
  ) {
    return notifier.build(
      queryString,
    );
  }

  @override
  Override overrideWith(SearchThread Function() create) {
    return ProviderOverride(
      origin: this,
      override: SearchThreadProvider._internal(
        () => create()..queryString = queryString,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        queryString: queryString,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SearchThread, List<Post>>
      createElement() {
    return _SearchThreadProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchThreadProvider && other.queryString == queryString;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, queryString.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchThreadRef on AutoDisposeAsyncNotifierProviderRef<List<Post>> {
  /// The parameter `queryString` of this provider.
  String get queryString;
}

class _SearchThreadProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SearchThread, List<Post>>
    with SearchThreadRef {
  _SearchThreadProviderElement(super.provider);

  @override
  String get queryString => (origin as SearchThreadProvider).queryString;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
