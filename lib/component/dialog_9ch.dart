import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dialog9ch extends ConsumerWidget {
  const Dialog9ch(
      {super.key,
      required this.title,
      this.content,
      required this.buttonLabel,
      this.onPressed,
      this.isCancelButton = true});
  final String title;
  final String? content;
  final String buttonLabel;
  final Function()? onPressed;
  final bool isCancelButton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      content: content != null ? Text(content!) : null,
      actions: [
        isCancelButton
            ? TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('キャンセル'))
            : const SizedBox.shrink(),
        TextButton(
            onPressed: onPressed,
            child: Text(
              buttonLabel,
              style: const TextStyle(
                  color: Color(0xffD0104C), fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
