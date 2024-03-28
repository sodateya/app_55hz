import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReadMark extends ConsumerWidget {
  const ReadMark({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
      right: -1,
      child: Container(
        alignment: Alignment.topRight,
        width: 25,
        height: 25,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // ignore: unnecessary_const
          color: const Color(0xffD0104C),
        ),
        child: const Padding(
          padding: EdgeInsets.only(top: 3.0, right: 2),
          child: Text('new',
              style: TextStyle(
                  color: Color(0xffFCFAF2),
                  fontSize: 11,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
