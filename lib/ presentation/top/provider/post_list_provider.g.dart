// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postListProviderHash() => r'689f5f387e74b950c80d694d4f9b2e48306d7d95';

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

abstract class _$PostListProvider
    extends BuildlessAutoDisposeAsyncNotifier<PostState> {
  late final Thread thread;

  FutureOr<PostState> build(
    Thread thread,
  );
}

/// See also [PostListProvider].
@ProviderFor(PostListProvider)
const postListProviderProvider = PostListProviderFamily();

/// See also [PostListProvider].
class PostListProviderFamily extends Family<AsyncValue<PostState>> {
  /// See also [PostListProvider].
  const PostListProviderFamily();

  /// See also [PostListProvider].
  PostListProviderProvider call(
    Thread thread,
  ) {
    return PostListProviderProvider(
      thread,
    );
  }

  @override
  PostListProviderProvider getProviderOverride(
    covariant PostListProviderProvider provider,
  ) {
    return call(
      provider.thread,
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
  String? get name => r'postListProviderProvider';
}

/// See also [PostListProvider].
class PostListProviderProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PostListProvider, PostState> {
  /// See also [PostListProvider].
  PostListProviderProvider(
    Thread thread,
  ) : this._internal(
          () => PostListProvider()..thread = thread,
          from: postListProviderProvider,
          name: r'postListProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postListProviderHash,
          dependencies: PostListProviderFamily._dependencies,
          allTransitiveDependencies:
              PostListProviderFamily._allTransitiveDependencies,
          thread: thread,
        );

  PostListProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.thread,
  }) : super.internal();

  final Thread thread;

  @override
  FutureOr<PostState> runNotifierBuild(
    covariant PostListProvider notifier,
  ) {
    return notifier.build(
      thread,
    );
  }

  @override
  Override overrideWith(PostListProvider Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostListProviderProvider._internal(
        () => create()..thread = thread,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        thread: thread,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PostListProvider, PostState>
      createElement() {
    return _PostListProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostListProviderProvider && other.thread == thread;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, thread.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostListProviderRef on AutoDisposeAsyncNotifierProviderRef<PostState> {
  /// The parameter `thread` of this provider.
  Thread get thread;
}

class _PostListProviderProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostListProvider, PostState>
    with PostListProviderRef {
  _PostListProviderProviderElement(super.provider);

  @override
  Thread get thread => (origin as PostListProviderProvider).thread;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
