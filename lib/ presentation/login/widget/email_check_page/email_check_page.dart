import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:app_55hz/router/provider/is_login_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmailCheckPage extends ConsumerWidget {
  const EmailCheckPage({super.key, required this.email, required this.pass});
  final String email;
  final String pass;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  icon: const Icon(Icons.arrow_back_ios_new))),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    '$email\nに確認メールを送信しました。',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref
                          .read(isLoginProvider.notifier)
                          .mailSignIn(email, pass)
                          .then((value) {
                        if (value) {
                          context.go(RouteConfig.top.path);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('メールの確認が済んでいません')));
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff33A6B8)),
                    child: const Text(
                      'メールを確認完了',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff434343)),
                    child: const Text(
                      '確認メール再送信',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
