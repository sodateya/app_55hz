import 'package:app_55hz/model/talk/talk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TalkComment extends ConsumerWidget {
  const TalkComment({super.key, required this.talk});
  final Talk talk;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: Text(talk.comment!),
    );
  }
}
