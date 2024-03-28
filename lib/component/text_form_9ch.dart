import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TextForm9ch extends ConsumerWidget {
  const TextForm9ch(
      {super.key,
      required this.labelText,
      required this.controller,
      this.maxLines,
      this.maxLength,
      this.suffixIcon});
  final String labelText;
  final TextEditingController controller;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
        style: const TextStyle(
          color: Color(0xff43341B),
        ),
        maxLength: maxLength,
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.black54),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Color(0xff33A6B8), width: 3.0),
          ),
        ));
  }
}
