// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/sign_out/sign_out_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/threads_list_provider.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class DefaultDrawer extends ConsumerWidget {
  const DefaultDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(firebaseAuthInstanceProvider).currentUser!.uid;
    return Drawer(
      backgroundColor: const Color(0xff939650),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/washi1.png'),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(
                        Color(0xff939650), BlendMode.modulate)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 56.0),
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              const Text('MyID:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff43341B),
                                      fontWeight: FontWeight.bold)),
                              SelectableText('   ${uid.substring(20)}',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Color(0xffFCFAF2),
                                      fontWeight: FontWeight.bold)),
                            ])),
                        IconButton(
                            onPressed: () async {
                              final data = ClipboardData(
                                  text: uid.substring(20).toString());
                              await Clipboard.setData(data).then((value) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          title: const Text('MyIDをコピーしました'),
                                          actions: [
                                            TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                })
                                          ]);
                                    });
                              });
                            },
                            icon: const Icon(FeatherIcons.copy,
                                color: Color(0xff43341B)))
                      ]),
                    ),
                    DrawerTile(
                        title: 'マイページ',
                        icon: FeatherIcons.user,
                        onTap: () {
                          context.push('/top/${RouteConfig.myPage.path}');
                        }),
                    DrawerTile(
                        title: 'お気に入り',
                        icon: FeatherIcons.heart,
                        onTap: () {
                          context.push('/top/${RouteConfig.favoritePage.path}');
                        }),
                    DrawerTile(
                        title: '設定',
                        icon: FeatherIcons.settings,
                        onTap: () async {
                          await context
                              .push('/top/${RouteConfig.settingPage.path}');
                          ref.invalidate(threadsListProvider);
                        }),
                    DrawerTile(
                        title: 'プロフィール編集',
                        icon: FeatherIcons.userCheck,
                        onTap: () {
                          context
                              .push('/top/${RouteConfig.editProfilePage.path}');
                        }),
                    DrawerTile(
                        title: 'ブロックリスト',
                        icon: FeatherIcons.userX,
                        onTap: () {
                          context
                              .push('/top/${RouteConfig.blockListPage.path}');
                        }),
                    DrawerTile(
                        title: '管理人とお話し',
                        icon: FeatherIcons.messageCircle,
                        onTap: () {
                          context
                              .push('/top/${RouteConfig.talkToAdminPage.path}');
                        }),
                    DrawerTile(
                        title: '利用規約\nプライバシーポリシー',
                        icon: FeatherIcons.sidebar,
                        onTap: () async {
                          await launch('https://hz-360fa.web.app/');
                        }),
                    DrawerTile(
                      title: 'お問い合わせ・退会手続き',
                      icon: FeatherIcons.send,
                      onTap: () {
                        context.push('/top/${RouteConfig.accountDelete.path}');
                      },
                    ),
                    DrawerTile(
                      title: 'ログアウト',
                      icon: FeatherIcons.logOut,
                      onTap: () {
                        ref.read(signOutProvider.notifier).signOut();
                        context.go(RouteConfig.login.path);
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Divider(color: Color(0xff43341B)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: Transform.rotate(
                              angle: 23.4 * pi / 180,
                              child: const Image(
                                image: AssetImage('images/logo.png'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('X : '),
                        const SelectableText('9channeru_'),
                        IconButton(
                            onPressed: () async {
                              await launch('https://twitter.com/9channeru_');
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.xTwitter,
                              color: Color(0xff43341B),
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('連絡先 : '),
                        const SelectableText('9channeru@gmail.com'),
                        IconButton(
                            onPressed: () async {
                              const data =
                                  ClipboardData(text: '9channeru@gmail.com');
                              await Clipboard.setData(data).then((value) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('連絡先コピーしました'),
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
                                );
                              });
                            },
                            icon: const Icon(
                              FeatherIcons.copy,
                              color: Color(0xff43341B),
                            ))
                      ],
                    ),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerTile extends ConsumerWidget {
  const DrawerTile(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});
  final void Function()? onTap;
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(title,
          style: const TextStyle(
            color: Color(0xffFCFAF2),
          )),
      leading: Icon(
        icon,
        color: const Color(0xffFCFAF2),
      ),
      onTap: onTap,
    );
  }
}
