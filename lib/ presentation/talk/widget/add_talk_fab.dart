import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTalkFab extends ConsumerWidget {
  const AddTalkFab({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: FloatingActionButton(
        heroTag: null,
        elevation: 9,
        backgroundColor: const Color(0xff0C4842).withOpacity(0.7),
        onPressed: onPressed,
        child: const Icon(
          FeatherIcons.edit,
          color: Color(0xffFCFAF2),
        ),
      ),
    );
  }
}
