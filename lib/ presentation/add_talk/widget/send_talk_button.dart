import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendTalkButton extends ConsumerWidget {
  const SendTalkButton({super.key, required this.onPressed});

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 116,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0C4842)),
                onPressed: onPressed,
                child: const Text(
                  '投稿する',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffFCFAF2),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
