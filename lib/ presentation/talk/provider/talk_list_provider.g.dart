// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$talkListHash() => r'a9ecf31fe0dca14a86cb6bded9d494a5cde89048';

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

abstract class _$TalkList extends BuildlessAutoDisposeAsyncNotifier<TalkState> {
  late final String postId;
  late final String threadId;

  FutureOr<TalkState> build(
    String postId,
    String threadId,
  );
}

/// See also [TalkList].
@ProviderFor(TalkList)
const talkListProvider = TalkListFamily();

/// See also [TalkList].
class TalkListFamily extends Family<AsyncValue<TalkState>> {
  /// See also [TalkList].
  const TalkListFamily();

  /// See also [TalkList].
  TalkListProvider call(
    String postId,
    String threadId,
  ) {
    return TalkListProvider(
      postId,
      threadId,
    );
  }

  @override
  TalkListProvider getProviderOverride(
    covariant TalkListProvider provider,
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
  String? get name => r'talkListProvider';
}

/// See also [TalkList].
class TalkListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TalkList, TalkState> {
  /// See also [TalkList].
  TalkListProvider(
    String postId,
    String threadId,
  ) : this._internal(
          () => TalkList()
            ..postId = postId
            ..threadId = threadId,
          from: talkListProvider,
          name: r'talkListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$talkListHash,
          dependencies: TalkListFamily._dependencies,
          allTransitiveDependencies: TalkListFamily._allTransitiveDependencies,
          postId: postId,
          threadId: threadId,
        );

  TalkListProvider._internal(
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
  FutureOr<TalkState> runNotifierBuild(
    covariant TalkList notifier,
  ) {
    return notifier.build(
      postId,
      threadId,
    );
  }

  @override
  Override overrideWith(TalkList Function() create) {
    return ProviderOverride(
      origin: this,
      override: TalkListProvider._internal(
        () => create()
          ..postId = postId
          ..threadId = threadId,
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
  AutoDisposeAsyncNotifierProviderElement<TalkList, TalkState> createElement() {
    return _TalkListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TalkListProvider &&
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

mixin TalkListRef on AutoDisposeAsyncNotifierProviderRef<TalkState> {
  /// The parameter `postId` of this provider.
  String get postId;

  /// The parameter `threadId` of this provider.
  String get threadId;
}

class _TalkListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TalkList, TalkState>
    with TalkListRef {
  _TalkListProviderElement(super.provider);

  @override
  String get postId => (origin as TalkListProvider).postId;
  @override
  String get threadId => (origin as TalkListProvider).threadId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
