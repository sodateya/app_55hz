import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogoImage extends ConsumerWidget {
  const LogoImage({super.key, this.size = 152});
  final double size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
          width: size,
          height: size,
          child: Transform.rotate(
              angle: 23.4 * pi / 180,
              child: const Image(image: AssetImage('images/logo.png')))),
    );
  }
}
