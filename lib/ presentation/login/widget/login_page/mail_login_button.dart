import 'package:app_55hz/%20presentation/login/enum/firebase_error_codes.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/agree/is_agree_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/signin/signin_user_credential_provider.dart';
import 'package:app_55hz/%20presentation/login/widget/dialog/agree_dialog.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MailLoginButton extends ConsumerWidget {
  const MailLoginButton(
      {super.key, required this.mailController, required this.passController});
  final TextEditingController mailController;
  final TextEditingController passController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agreeToTerms = ref.watch(isAgreeProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
              },
            );
          } else {
            final notifier = ref.read(signinUserCredentialProvider.notifier);
            await notifier
                .mailLogIn(mailController.text, passController.text)
                .catchError((e) {
              final error = FirebaseAuthErrorCodes.fromCode(e.code).message;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error)));
            }).then((result) {
              if (result != null && result is UserCredential) {
                result.user!.emailVerified
                    ? context.go(RouteConfig.top.path)
                    : result.user!.sendEmailVerification().then((value) =>
                        context.push(
                            '${RouteConfig.login.path}/${RouteConfig.emailCheckPage.path}/${mailController.text}/${passController.text}'));
              }
            });
          }
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          elevation: 1,
          backgroundColor: const Color(0xff33A6B8).withOpacity(0.9),
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
          child:
              const Text('メールログイン', style: TextStyle(color: Color(0xff43341B))),
        ),
      ),
    );
  }
}
