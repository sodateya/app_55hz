// ignore_for_file: must_be_immutable

import 'dart:math';
import 'package:app_55hz/main.dart';
import 'package:app_55hz/presentation/block_list/block_list_page.dart';
import 'package:app_55hz/presentation/edit_thread/edit_thread_page.dart';
import 'package:app_55hz/presentation/login/login.dart';
import 'package:app_55hz/presentation/my_favorite_page/my_favorite_page.dart';
import 'package:app_55hz/presentation/talk_to_admin/talk_to_admin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';
import '../presentation/account_delete/account_delete_page.dart';
import '../presentation/list/list_model.dart';
import '../presentation/my_page/my_threads_page.dart';
import '../presentation/profile_edit/profile_edit_page.dart';
import '../presentation/test/friend_page.dart';
import '../presentation/test/test_page.dart';

class DefaultDrawer extends StatelessWidget {
  String uid;
  String sort;
  FirebaseAuth auth;
  bool isChanged = false;
  ListModel model;

  DefaultDrawer(
      {Key key, this.uid, this.auth, this.isChanged, this.model, this.sort})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: const Color(0xff939650),
          textTheme: TextTheme(
              bodyText2:
                  GoogleFonts.sawarabiMincho(color: const Color(0xff43341B)),
              button: GoogleFonts.sawarabiMincho())),
      child: SafeArea(
        bottom: true,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(150)),
          child: Drawer(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/washi1.png'),
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Color(0xff616138), BlendMode.modulate)),
                  ),
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('MyID:',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff43341B),
                                  fontWeight: FontWeight.bold)),
                          SelectableText(
                            '   ${uid.substring(20)}',
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xffFCFAF2),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                          onPressed: () async {
                            final data = ClipboardData(
                                text: uid.substring(20).toString());
                            await Clipboard.setData(data);
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('MyIDをコピーしました'),
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
                          },
                          icon: const Icon(Feather.copy,
                              color: Color(0xff43341B)))
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/washi1.png'),
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                  Color(0xff939650), BlendMode.modulate)),
                        ),
                        height: MediaQuery.of(context).size.height * 0.841,
                        child: ListView(
                          children: [
                            DrawerTile(() async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyThreadsPage(
                                          uid: uid,
                                          adInterstitial: adInterstitial,
                                          sort: sort)));
                            }, 'マイページ', Feather.user),
                            DrawerTile(() async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyFavoritePage(uid: uid)));
                            }, 'お気に入り', Feather.heart),
                            DrawerTile(() async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditThreadPage(uid: uid)));
                              if (result == true) {
                                await model.fetchThread(uid);
                                await model.getConfig();
                              }
                            }, '設定', Feather.settings),
                            DrawerTile(() async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileEditPage(uid: uid)));
                            }, 'プロフィール編集', Feather.user_check),
                            DrawerTile(() async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BlockListPage(uid: uid)));
                            }, 'ブロックリスト', Feather.user_x),
                            DrawerTile(() async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TalkToAdminPage(uid: uid)));
                            }, '管理人とお話し', Feather.message_circle),
                            DrawerTile(() async {
                              await launch('https://hz-360fa.web.app/');
                            }, '利用規約\nプライバシーポリシー', Feather.sidebar),
                            DrawerTile(() async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AccountDeletePage(
                                            uid: uid,
                                            adInterstitial: adInterstitial,
                                          )));
                            }, 'お問い合わせ・退会手続き', Feather.send),
                            DrawerTile(() async {
                              try {
                                auth.signOut();
                              } catch (e) {
                                GoogleSignIn().signOut();
                              }
                              auth.signOut();
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login(
                                          adInterstitial: adInterstitial)));
                            }, 'ログアウト', Feather.log_out),
                            DrawerTile(() async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FriendPage(uid: uid)));
                            }, 'test', Feather.log_out),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                const Text('連絡先 : '),
                                const SelectableText('9channeru@gmail.com'),
                                IconButton(
                                    onPressed: () async {
                                      const data = ClipboardData(
                                          text: '9channeru@gmail.com');
                                      await Clipboard.setData(data);
                                      await showDialog(
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
                                    },
                                    icon: const Icon(
                                      Feather.copy,
                                      color: Color(0xff43341B),
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Twitter : '),
                                const SelectableText('9channeru_'),
                                IconButton(
                                    onPressed: () async {
                                      await launch(
                                          'https://twitter.com/9channeru_');
                                    },
                                    icon: const Icon(
                                      Feather.twitter,
                                      color: Color(0xff43341B),
                                    ))
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  DrawerTile(this.onTap, this.title, this.icon, {Key key}) : super(key: key);
  final VoidCallback onTap;
  String title;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,
          style: GoogleFonts.sawarabiMincho(
            color: const Color(0xffFCFAF2),
          )),
      leading: Icon(
        icon,
        color: const Color(0xffFCFAF2),
      ),
      onTap: onTap,
    );
  }
}
