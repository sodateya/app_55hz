import 'package:app_55hz/%20presentation/add_talk/provider/pick_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeletePickedImageButton extends ConsumerWidget {
  const DeletePickedImageButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff0C4842)),
            minimumSize: MaterialStateProperty.all<Size>(const Size(30, 30)),
            shape:
                MaterialStateProperty.all<CircleBorder>(const CircleBorder())),
        onPressed: () {
          ref.read(pickImageProvider.notifier).remove();
        },
        child: const Icon(
          FeatherIcons.x,
          color: Color(0xffFCFAF2),
        ));
  }
}
