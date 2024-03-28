// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_image_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pickImageHash() => r'90212c943e136468a06de7d516649344ee381305';

/// See also [PickImage].
@ProviderFor(PickImage)
final pickImageProvider =
    AutoDisposeNotifierProvider<PickImage, File?>.internal(
  PickImage.new,
  name: r'pickImageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pickImageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PickImage = AutoDisposeNotifier<File?>;
String _$isUploadingPictureHash() =>
    r'078b8dfa10b946ddd18f3642f431c062552363f6';

/// 画像を送信中かを管理するプロバイダー
///
/// Copied from [IsUploadingPicture].
@ProviderFor(IsUploadingPicture)
final isUploadingPictureProvider =
    AutoDisposeNotifierProvider<IsUploadingPicture, bool>.internal(
  IsUploadingPicture.new,
  name: r'isUploadingPictureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUploadingPictureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsUploadingPicture = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
