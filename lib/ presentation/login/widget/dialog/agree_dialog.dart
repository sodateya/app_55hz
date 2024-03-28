import 'package:app_55hz/%20presentation/login/provider/auth/agree/is_agree_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/agree/read_agree_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreeDialog extends ConsumerWidget {
  const AgreeDialog({super.key, this.text = '利用規約をお読みになってから同意してください'});
  final String? text;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text(text!),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('閉じる')),
            TextButton(
                onPressed: () {
                  final readNotifier = ref.read(readAgreeProvider.notifier);
                  final agreeNotifier = ref.read(isAgreeProvider.notifier);
                  launchUrl(
                    Uri.parse('https://hz-360fa.web.app/'),
                  );
                  readNotifier.changeRead(true);
                  agreeNotifier.changeAgree(true);
                  Navigator.pop(context);
                },
                child: const Text('利用規約を読む'))
          ],
        )
      ],
    );
  }
}
