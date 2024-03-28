import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgetPasswordPage extends HookConsumerWidget {
  const ForgetPasswordPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final mailController = useTextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          const BackImg(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'パスワードを再設定',
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'メールアドレスを入力してください';
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return '有効なメールアドレスを入力してください。';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      decoration: const InputDecoration(
                          labelStyle: TextStyle(fontSize: 12),
                          labelText: 'メールアドレス'),
                      controller: mailController),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFCFAF2),
                          padding: const EdgeInsets.all(16),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          '戻る',
                          style: TextStyle(
                            color: Color(0xff43341B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16), // 適切なスペースを追加
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await ref
                                .read(firebaseAuthInstanceProvider)
                                .sendPasswordResetEmail(
                                    email: mailController.text)
                                .then((value) => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text(
                                            '${mailController.text}に再発行メールを送信しました'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                context
                                                    .go(RouteConfig.login.path);
                                              },
                                              child: const Text('とじる'))
                                        ],
                                      );
                                    }));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff33A6B8),
                          padding: const EdgeInsets.all(16),
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        child: const Text(
                          '再設定メールを送信',
                          style: TextStyle(
                            color: Color(0xffFCFAF2),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
