import 'dart:io';

import 'package:app_55hz/%20presentation/add_talk/provider/pick_image_provider.dart';
import 'package:app_55hz/%20presentation/add_talk/widget/image_widget/delete_picked_image_button.dart';
import 'package:app_55hz/%20presentation/add_talk/widget/image_widget/edit_image_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PickedImage9ch extends ConsumerWidget {
  const PickedImage9ch({super.key, required this.image});
  final File image;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUpload = ref.watch(isUploadingPictureProvider);

    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                SizedBox(width: 150, height: 100, child: Image.file(image)),
                isUpload
                    ? const Positioned(
                        top: 35, right: 55, child: CircularProgressIndicator())
                    : const SizedBox.shrink()
              ],
            ),
            isUpload ? const SizedBox.shrink() : const EditImageButton()
          ],
        ),
        isUpload
            ? const SizedBox.shrink()
            : const Positioned(
                top: -8, right: -16, child: DeletePickedImageButton())
      ],
    );
  }
}
