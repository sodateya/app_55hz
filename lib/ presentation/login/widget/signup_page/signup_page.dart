import 'dart:developer';

import 'package:app_55hz/%20presentation/login/enum/firebase_error_codes.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/mail/pass_is_ok_provider.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:app_55hz/router/provider/is_login_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mailController = useTextEditingController();
    final passController = useTextEditingController();
    final passIsOk = ref.watch(passIsOkProvider);
    final formKey = GlobalKey<FormState>();
    final isLogin = ref.watch(isLoginProvider);
    return Scaffold(
      body: Stack(
        children: [
          const BackImg(),
          Positioned(
            top: 80,
            left: 10,
            child: IconButton(
                onPressed: () {
                  context.pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'アカウント新規作成',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!);
                          if (value.isEmpty) {
                            return 'メールアドレスを入力してください';
                          }
                          if (!emailValid) {
                            return '有効なメールアドレスを入力してください。';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            labelStyle: TextStyle(fontSize: 12),
                            labelText: 'メールアドレス'),
                        controller: mailController),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 12),
                          labelText: 'パスワード(8〜20文字)'),
                      onChanged: (String value) {
                        ref.read(passIsOkLogicProvider.notifier).change(value);
                      },
                      controller: passController),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    onPressed: passIsOk
                        ? () async {
                            if (formKey.currentState!.validate()) {
                              if (context.mounted) {
                                final auth =
                                    ref.watch(firebaseAuthInstanceProvider);
                                try {
                                  if (!isLogin) {
                                    await auth.createUserWithEmailAndPassword(
                                      email: mailController.text,
                                      password: passController.text,
                                    );
                                  }
                                  final user = auth.currentUser!;
                                  user.sendEmailVerification().then((value) =>
                                      context.push(
                                          '${RouteConfig.login.path}/${RouteConfig.emailCheckPage.path}/${mailController.text}/${passController.text}'));
                                } catch (e) {
                                  if (e is FirebaseAuthException) {
                                    final error =
                                        FirebaseAuthErrorCodes.fromCode(e.code)
                                            .message;
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(error)));
                                  } else {
                                    // それ以外の例外が発生した場合
                                    log('Unexpected Error: $e');
                                  }
                                }
                              }
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff33A6B8)),
                    child: const Text(
                      '確認メールを送信する',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
