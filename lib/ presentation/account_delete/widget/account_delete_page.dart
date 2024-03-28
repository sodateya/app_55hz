import 'package:app_55hz/%20presentation/account_delete/provider/account_delete_provider.dart';
import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/component/dialog_9ch.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountDeletePage extends ConsumerWidget {
  const AccountDeletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.read(firebaseAuthInstanceProvider);
    final uid = auth.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarBackImg(),
        title: const Text(
          'お問い合わせ',
          style: TextStyle(color: Color(0xffFCFAF2), fontSize: 20.0),
        ),
      ),
      body: Stack(
        children: [
          const BackImg(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text(
                      '〜 ユーザー情報 〜',
                      style: TextStyle(color: Color(0xff43341B), fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'ユーザーID : ${uid.substring(20)}\nE-mail : ${auth.currentUser!.email}',
                      style: const TextStyle(
                        color: Color(0xff43341B),
                      ),
                    ),
                    TextButton(
                      child: const Text('ユーザー情報をコピー',
                          style: TextStyle(color: Color(0xff33A6B8))),
                      onPressed: () async {
                        final data = ClipboardData(
                            text:
                                'ユーザーID : ${uid.substring(20)}\nE-mail : ${auth.currentUser!.email}');
                        await Clipboard.setData(data)
                            .then((value) => showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('ユーザー情報をコピーしました'),
                                      actions: [
                                        TextButton(
                                          child: const Text('閉じる'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ));
                      },
                    )
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0C4842),
                  ),
                  label: const Text('メールを送る',
                      style: TextStyle(color: Color(0xffFCFAF2))),
                  icon: const Icon(FeatherIcons.mail),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('メールを送りますか？'),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  child: const Text('いいえ'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('メールアプリを開く'),
                                  onPressed: () async {
                                    ref
                                        .read(accountDeleteProvider.notifier)
                                        .openMailApp(uid,
                                            auth.currentUser!.email.toString());
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                      '※メールアプリがお使いのデバイスにインストールされていない場合は、ユーザー情報を記載し、以下のメールアドレスにPCや他のデバイスからご連絡ください',
                      style: TextStyle(color: Color(0xff43341B))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('9channeru@gmail.com',
                        style: TextStyle(color: Color(0xff43341B))),
                    IconButton(
                        onPressed: () async {
                          const data =
                              ClipboardData(text: '9channeru@gmail.com');
                          await Clipboard.setData(data).then((value) =>
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('9ちゃんねるのメールアドレスをコピーしました'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ));
                        },
                        icon: const Icon(FeatherIcons.copy,
                            color: Color(0xff43341B)))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffD0104C),
                  ),
                  label: const Text('退会手続き',
                      style: TextStyle(color: Color(0xffFCFAF2))),
                  icon: const Icon(FeatherIcons.trash2),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog9ch(
                          title: 'アカウントを削除しますか？',
                          buttonLabel: '削除する',
                          content: '※削除後は二度とアカウントの復旧はできません',
                          onPressed: () async {
                            //Delete
                            await auth.currentUser!.delete().catchError((e) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.black54,
                                    title: const Text(
                                        'エラーが発生しました。\n一度ログインをし直して、再度削除を実行してください',
                                        style: TextStyle(
                                            color: Color(0xffFCFAF2),
                                            fontSize: 15)),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                            child: const Text('ログアウト',
                                                style: TextStyle(
                                                    color: Color(0xff33A6B8),
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            onPressed: () async {
                                              GoogleSignIn().signOut();
                                              auth.signOut();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            }).then((value) {
                              GoogleSignIn().signOut();
                              auth.signOut();

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog9ch(
                                      title: 'アカウントを削除しました。',
                                      buttonLabel: 'ログイン画面へ戻る',
                                      isCancelButton: false,
                                      onPressed: () {
                                        context.pop();
                                        context.push(RouteConfig.login.path);
                                      },
                                    );
                                  });
                            });

                            //LoginPage
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter, child: const BannerWidget()),
        ],
      ),
    );
  }
}
