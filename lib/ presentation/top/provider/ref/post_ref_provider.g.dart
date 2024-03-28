// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_ref_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postRefHash() => r'c0d91dd84311a85b751b3ced07ae4f790fceb13c';

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

/// See also [postRef].
@ProviderFor(postRef)
const postRefProvider = PostRefFamily();

/// See also [postRef].
class PostRefFamily extends Family<CollectionReference<Post>> {
  /// See also [postRef].
  const PostRefFamily();

  /// See also [postRef].
  PostRefProvider call(
    String id,
  ) {
    return PostRefProvider(
      id,
    );
  }

  @override
  PostRefProvider getProviderOverride(
    covariant PostRefProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'postRefProvider';
}

/// See also [postRef].
class PostRefProvider extends AutoDisposeProvider<CollectionReference<Post>> {
  /// See also [postRef].
  PostRefProvider(
    String id,
  ) : this._internal(
          (ref) => postRef(
            ref as PostRefRef,
            id,
          ),
          from: postRefProvider,
          name: r'postRefProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postRefHash,
          dependencies: PostRefFamily._dependencies,
          allTransitiveDependencies: PostRefFamily._allTransitiveDependencies,
          id: id,
        );

  PostRefProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    CollectionReference<Post> Function(PostRefRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostRefProvider._internal(
        (ref) => create(ref as PostRefRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CollectionReference<Post>> createElement() {
    return _PostRefProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostRefProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostRefRef on AutoDisposeProviderRef<CollectionReference<Post>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PostRefProviderElement
    extends AutoDisposeProviderElement<CollectionReference<Post>>
    with PostRefRef {
  _PostRefProviderElement(super.provider);

  @override
  String get id => (origin as PostRefProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
