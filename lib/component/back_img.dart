import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BackImg extends ConsumerWidget {
  final Color? color;
  final double? colorOpacity;

  const BackImg(
      {super.key,
      this.colorOpacity = 0.4,
      this.color = const Color(0xffFCFAF2)});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            color!.withOpacity(colorOpacity!),
            BlendMode.dstATop,
          ),
          image: const AssetImage('images/washi1.png'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class AppBarBackImg extends ConsumerWidget {
  const AppBarBackImg({super.key, this.color = const Color(0xff616138)});
  final Color? color;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('images/washi1.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            color!,
            BlendMode.modulate,
          ),
        ),
      ),
    );
  }
}
