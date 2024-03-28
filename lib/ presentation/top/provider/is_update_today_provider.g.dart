// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_update_today_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isUpdateTodayHash() => r'75b6b50bb5d81e656d76b7d2323ce64d2ff3140a';

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

/// See also [isUpdateToday].
@ProviderFor(isUpdateToday)
const isUpdateTodayProvider = IsUpdateTodayFamily();

/// See also [isUpdateToday].
class IsUpdateTodayFamily extends Family<bool> {
  /// See also [isUpdateToday].
  const IsUpdateTodayFamily();

  /// See also [isUpdateToday].
  IsUpdateTodayProvider call(
    DateTime upDateAt,
  ) {
    return IsUpdateTodayProvider(
      upDateAt,
    );
  }

  @override
  IsUpdateTodayProvider getProviderOverride(
    covariant IsUpdateTodayProvider provider,
  ) {
    return call(
      provider.upDateAt,
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
  String? get name => r'isUpdateTodayProvider';
}

/// See also [isUpdateToday].
class IsUpdateTodayProvider extends AutoDisposeProvider<bool> {
  /// See also [isUpdateToday].
  IsUpdateTodayProvider(
    DateTime upDateAt,
  ) : this._internal(
          (ref) => isUpdateToday(
            ref as IsUpdateTodayRef,
            upDateAt,
          ),
          from: isUpdateTodayProvider,
          name: r'isUpdateTodayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isUpdateTodayHash,
          dependencies: IsUpdateTodayFamily._dependencies,
          allTransitiveDependencies:
              IsUpdateTodayFamily._allTransitiveDependencies,
          upDateAt: upDateAt,
        );

  IsUpdateTodayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.upDateAt,
  }) : super.internal();

  final DateTime upDateAt;

  @override
  Override overrideWith(
    bool Function(IsUpdateTodayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsUpdateTodayProvider._internal(
        (ref) => create(ref as IsUpdateTodayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        upDateAt: upDateAt,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsUpdateTodayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsUpdateTodayProvider && other.upDateAt == upDateAt;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, upDateAt.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin IsUpdateTodayRef on AutoDisposeProviderRef<bool> {
  /// The parameter `upDateAt` of this provider.
  DateTime get upDateAt;
}

class _IsUpdateTodayProviderElement extends AutoDisposeProviderElement<bool>
    with IsUpdateTodayRef {
  _IsUpdateTodayProviderElement(super.provider);

  @override
  DateTime get upDateAt => (origin as IsUpdateTodayProvider).upDateAt;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
