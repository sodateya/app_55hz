// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_block_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$accessBlockListHash() => r'315ba2d754763221c9803e1f30d83afa12609599';

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

abstract class _$AccessBlockList
    extends BuildlessAutoDisposeAsyncNotifier<List> {
  late final String threadId;
  late final String postId;

  FutureOr<List> build(
    String threadId,
    String postId,
  );
}

/// See also [AccessBlockList].
@ProviderFor(AccessBlockList)
const accessBlockListProvider = AccessBlockListFamily();

/// See also [AccessBlockList].
class AccessBlockListFamily extends Family<AsyncValue<List>> {
  /// See also [AccessBlockList].
  const AccessBlockListFamily();

  /// See also [AccessBlockList].
  AccessBlockListProvider call(
    String threadId,
    String postId,
  ) {
    return AccessBlockListProvider(
      threadId,
      postId,
    );
  }

  @override
  AccessBlockListProvider getProviderOverride(
    covariant AccessBlockListProvider provider,
  ) {
    return call(
      provider.threadId,
      provider.postId,
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
  String? get name => r'accessBlockListProvider';
}

/// See also [AccessBlockList].
class AccessBlockListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AccessBlockList, List> {
  /// See also [AccessBlockList].
  AccessBlockListProvider(
    String threadId,
    String postId,
  ) : this._internal(
          () => AccessBlockList()
            ..threadId = threadId
            ..postId = postId,
          from: accessBlockListProvider,
          name: r'accessBlockListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$accessBlockListHash,
          dependencies: AccessBlockListFamily._dependencies,
          allTransitiveDependencies:
              AccessBlockListFamily._allTransitiveDependencies,
          threadId: threadId,
          postId: postId,
        );

  AccessBlockListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.threadId,
    required this.postId,
  }) : super.internal();

  final String threadId;
  final String postId;

  @override
  FutureOr<List> runNotifierBuild(
    covariant AccessBlockList notifier,
  ) {
    return notifier.build(
      threadId,
      postId,
    );
  }

  @override
  Override overrideWith(AccessBlockList Function() create) {
    return ProviderOverride(
      origin: this,
      override: AccessBlockListProvider._internal(
        () => create()
          ..threadId = threadId
          ..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        threadId: threadId,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AccessBlockList, List>
      createElement() {
    return _AccessBlockListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AccessBlockListProvider &&
        other.threadId == threadId &&
        other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, threadId.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AccessBlockListRef on AutoDisposeAsyncNotifierProviderRef<List> {
  /// The parameter `threadId` of this provider.
  String get threadId;

  /// The parameter `postId` of this provider.
  String get postId;
}

class _AccessBlockListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AccessBlockList, List>
    with AccessBlockListRef {
  _AccessBlockListProviderElement(super.provider);

  @override
  String get threadId => (origin as AccessBlockListProvider).threadId;
  @override
  String get postId => (origin as AccessBlockListProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
