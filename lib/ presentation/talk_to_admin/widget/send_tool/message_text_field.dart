import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageTextField extends HookConsumerWidget {
  const MessageTextField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: TextFormField(
        maxLines: 10,
        minLines: 1,
        onChanged: (value) {
          controller.text = value;
        },
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Aa',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          fillColor: const Color(0xFFF0F0F0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    ));
  }
}
