import 'package:app_55hz/%20presentation/login/provider/auth/agree/is_agree_provider.dart';
import 'package:app_55hz/%20presentation/login/widget/dialog/agree_dialog.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MailSignUpButton extends ConsumerWidget {
  const MailSignUpButton({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agreeToTerms = ref.watch(isAgreeProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        onPressed: () async {
          if (!agreeToTerms) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AgreeDialog(
                    text: '利用規約に同意してください',
                  );
                });
          } else {
            await context
                .push('${RouteConfig.login.path}/${RouteConfig.singUp.path}');
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: const Color(0xffFCFAF2).withOpacity(0.9),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          alignment: Alignment.center,
          child: const Text('新規登録', style: TextStyle(color: Color(0xff43341B))),
        ),
      ),
    );
  }
}
