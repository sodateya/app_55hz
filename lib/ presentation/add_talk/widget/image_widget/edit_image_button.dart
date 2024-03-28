import 'package:app_55hz/%20presentation/add_talk/provider/pick_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditImageButton extends ConsumerWidget {
  const EditImageButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 168,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff0C4842)),
            onPressed: () {
              ref.read(pickImageProvider.notifier).pickImage();
            },
            child: const Row(
              children: [
                Icon(
                  FeatherIcons.edit,
                  color: Color(0xffFCFAF2),
                ),
                SizedBox(width: 8),
                Text(
                  '写真を編集',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffFCFAF2),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
