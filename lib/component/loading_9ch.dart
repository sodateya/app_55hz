import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Loading9ch extends ConsumerWidget {
  const Loading9ch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black54,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: 250,
              child: Image(
                image: AssetImage('images/logo.gif'),
              ),
            ),
            Text('〜アップロード中〜', style: TextStyle(color: Color(0xffFCFAF2))),
          ],
        ));
  }
}
