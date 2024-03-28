import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pick_image_provider.g.dart';

@riverpod
class PickImage extends _$PickImage {
  @override
  File? build() {
    return null;
  }

  final picker = ImagePicker();

  void pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      state = File(pickedFile.path);
    }
  }

// リストから削除(×ボタンを押した時の処理)
  void remove() {
    state = null;
  }
}

@riverpod

/// 画像を送信中かを管理するプロバイダー
class IsUploadingPicture extends _$IsUploadingPicture {
  @override
  bool build() {
    return false;
  }

  void startUpload() {
    state = true;
  }

  void endUpload() {
    state = false;
  }
}
