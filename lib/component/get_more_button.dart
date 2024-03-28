import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetMoreButton extends ConsumerWidget {
  const GetMoreButton({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: onPressed,
              child: const Text(
                'さらに表示する',
                style: TextStyle(
                    color: Color(0xff78C2C4), fontWeight: FontWeight.bold),
              )),
        ),
        const SizedBox(
          height: 128,
        )
      ],
    );
  }
}
