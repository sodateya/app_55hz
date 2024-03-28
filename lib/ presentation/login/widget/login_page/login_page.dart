import 'dart:math';

import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/login/widget/login_page/agree_text.dart';
import 'package:app_55hz/%20presentation/login/widget/login_page/apple_login_button.dart';
import 'package:app_55hz/%20presentation/login/widget/login_page/google_login_button.dart';
import 'package:app_55hz/%20presentation/login/widget/login_page/mail_login_button.dart';
import 'package:app_55hz/%20presentation/login/widget/login_page/mail_sign_up_button.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscure = useState(false);
    final mailController = useTextEditingController();
    final passController = useTextEditingController();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          primaryFocus?.unfocus();
        },
        child: Center(
          child: Stack(
            children: [
              const BackImg(),
              Center(
                child: SingleChildScrollView(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Transform.rotate(
                              angle: 23.4 * pi / 180,
                              child: const Image(
                                image: AssetImage('images/logo.png'),
                              ),
                            ),
                          ),
                          TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  labelStyle: TextStyle(fontSize: 12),
                                  labelText: 'メールアドレス'),
                              controller: mailController),
                          TextField(
                              obscureText: isObscure.value,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      isObscure.value = !isObscure.value;
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      color: isObscure.value
                                          ? const Color(0xff33A6B8)
                                          : const Color(0xff43341B),
                                    ),
                                  ),
                                  labelStyle: const TextStyle(fontSize: 12),
                                  labelText: 'パスワード'),
                              controller: passController),
                          MailLoginButton(
                            mailController: mailController,
                            passController: passController,
                          ),
                          const MailSignUpButton(),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [GoogleLoginButton(), AppleLoginButton()],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: InkWell(
                              onTap: () {
                                context.push(
                                    '${RouteConfig.login.path}/${RouteConfig.forgetPassword.path}');
                              },
                              child: const Text('パスワードを忘れた方はこちら',
                                  style: TextStyle(
                                    color: Color(0xff33A6B8),
                                  )),
                            ),
                          ),
                          const AgreeText(),
                          Container(
                              alignment: Alignment.bottomCenter,
                              child: const BannerWidget()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
