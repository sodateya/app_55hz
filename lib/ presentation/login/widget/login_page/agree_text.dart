import 'package:app_55hz/%20presentation/login/provider/auth/agree/is_agree_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/agree/read_agree_provider.dart';
import 'package:app_55hz/%20presentation/login/widget/dialog/agree_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class AgreeText extends ConsumerWidget {
  const AgreeText({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agreeToTerms = ref.watch(isAgreeProvider);
    final readTerms = ref.watch(readAgreeProvider);
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ご利用前に必ず', style: DefaultTextStyle.of(context).style),
              GestureDetector(
                  child: const Text('利用規約に同意',
                      style: TextStyle(
                          color: Color(0xff33A6B8), // ボタンの色
                          decoration: TextDecoration.underline)),
                  onTap: () {
                    launchUrl(Uri.parse('https://hz-360fa.web.app/'));
                    final readNotifier = ref.read(readAgreeProvider.notifier);
                    readNotifier.changeRead(true);
                  }),
              Text('してください。', style: DefaultTextStyle.of(context).style)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: agreeToTerms,
                onChanged: (value) {
                  if (readTerms == false) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AgreeDialog();
                        });
                  } else {
                    final agreeNotifier = ref.read(isAgreeProvider.notifier);
                    agreeNotifier.changeAgree(value!);
                  }
                },
              ),
              const Text('同意する'),
            ],
          )
        ],
      ),
    );
  }
}
