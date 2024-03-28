import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendMessageButton extends ConsumerWidget {
  const SendMessageButton({super.key, required this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: onTap != null
                ? const Color(0xff2d3441)
                : const Color(0xff787878)),
        child: GestureDetector(
          onTap: onTap,
          child: const Icon(
            Icons.send,
            color: Color(0xFFF0F0F0),
            size: 16,
          ),
        ),
      ),
    );
  }
}
