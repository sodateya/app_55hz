// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk_ref_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$talkRefHash() => r'4a58448beff629eccd629d01977a93173d2384b5';

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

/// See also [talkRef].
@ProviderFor(talkRef)
const talkRefProvider = TalkRefFamily();

/// See also [talkRef].
class TalkRefFamily extends Family<CollectionReference<Talk>> {
  /// See also [talkRef].
  const TalkRefFamily();

  /// See also [talkRef].
  TalkRefProvider call(
    String postId,
    String threadId,
  ) {
    return TalkRefProvider(
      postId,
      threadId,
    );
  }

  @override
  TalkRefProvider getProviderOverride(
    covariant TalkRefProvider provider,
  ) {
    return call(
      provider.postId,
      provider.threadId,
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
  String? get name => r'talkRefProvider';
}

/// See also [talkRef].
class TalkRefProvider extends AutoDisposeProvider<CollectionReference<Talk>> {
  /// See also [talkRef].
  TalkRefProvider(
    String postId,
    String threadId,
  ) : this._internal(
          (ref) => talkRef(
            ref as TalkRefRef,
            postId,
            threadId,
          ),
          from: talkRefProvider,
          name: r'talkRefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$talkRefHash,
          dependencies: TalkRefFamily._dependencies,
          allTransitiveDependencies: TalkRefFamily._allTransitiveDependencies,
          postId: postId,
          threadId: threadId,
        );

  TalkRefProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
    required this.threadId,
  }) : super.internal();

  final String postId;
  final String threadId;

  @override
  Override overrideWith(
    CollectionReference<Talk> Function(TalkRefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TalkRefProvider._internal(
        (ref) => create(ref as TalkRefRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
        threadId: threadId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CollectionReference<Talk>> createElement() {
    return _TalkRefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TalkRefProvider &&
        other.postId == postId &&
        other.threadId == threadId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);
    hash = _SystemHash.combine(hash, threadId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TalkRefRef on AutoDisposeProviderRef<CollectionReference<Talk>> {
  /// The parameter `postId` of this provider.
  String get postId;

  /// The parameter `threadId` of this provider.
  String get threadId;
}

class _TalkRefProviderElement
    extends AutoDisposeProviderElement<CollectionReference<Talk>>
    with TalkRefRef {
  _TalkRefProviderElement(super.provider);

  @override
  String get postId => (origin as TalkRefProvider).postId;
  @override
  String get threadId => (origin as TalkRefProvider).threadId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
