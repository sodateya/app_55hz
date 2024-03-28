import 'package:app_55hz/model/talk/talk.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class TalkUrl extends ConsumerWidget {
  const TalkUrl({super.key, required this.talk});
  final Talk talk;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return talk.url != ''
        ? RichText(
            maxLines: 2,
            text: TextSpan(children: [
              TextSpan(
                  text: talk.url,
                  style: const TextStyle(
                    color: Color(0xff33A6B8),
                    fontSize: 14.0,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (await canLaunch(talk.url!)) {
                        await launch(talk.url!);
                      } else {
                        try {
                          await launch(talk.url!);
                        } catch (e) {
                          print('error');
                        }
                      }
                    })
            ]))
        : const SizedBox.shrink();
  }
}
