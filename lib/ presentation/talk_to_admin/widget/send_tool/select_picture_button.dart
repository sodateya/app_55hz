import 'package:app_55hz/%20presentation/add_talk/provider/pick_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectPictureButton extends ConsumerWidget {
  const SelectPictureButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: const Color(0xff2d3441)),
        child: GestureDetector(
          child: const Icon(
            Icons.image,
            color: Color(0xffFCFAF2),
            size: 16,
          ),
          onTap: () async {
            final notifier = ref.read(pickImageProvider.notifier);
            notifier.pickImage();
          },
        ),
      ),
    );
  }
}
