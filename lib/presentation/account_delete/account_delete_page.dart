// ignore_for_file: use_build_context_synchronously, must_be_immutable, missing_return

import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/account_delete/account_delete_model.dart';
import 'package:app_55hz/presentation/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class AccountDeletePage extends StatelessWidget {
  String uid;
  AdInterstitial adInterstitial;

  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();
  AccountDeletePage(
      {super.key, required this.uid, required this.adInterstitial});
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: AccountDeleteModel(),
        builder: (context, snapshot) {
          return Consumer<AccountDeleteModel>(builder: (context, model, child) {
            return Scaffold(
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/washi1.png'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Color(0xff616138),
                        BlendMode.modulate,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'お問い合わせ',
                  style: GoogleFonts.sawarabiMincho(
                      color: const Color(0xffFCFAF2), fontSize: 20.0),
                ),
                backgroundColor: const Color(0xff616138),
              ),
              body: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        const Color(0xffFCFAF2).withOpacity(0.4),
                        BlendMode.dstATop,
                      ),
                      image: const AssetImage('images/washi1.png'),
                      fit: BoxFit.fill,
                    )),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              '〜 ユーザー情報 〜',
                              style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xff43341B), fontSize: 20),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'ユーザーID : ${uid.substring(20)}\nE-mail : ${auth.currentUser!.email}',
                              style: GoogleFonts.sawarabiMincho(
                                color: const Color(0xff43341B),
                              ),
                            ),
                            TextButton(
                              child: Text('ユーザー情報をコピー',
                                  style: GoogleFonts.sawarabiMincho(
                                      color: const Color(0xff33A6B8))),
                              onPressed: () async {
                                final data = ClipboardData(
                                    text:
                                        'ユーザーID : ${uid.substring(20)}\nE-mail : ${auth.currentUser!.email}');
                                await Clipboard.setData(data);
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('ユーザー情報をコピーしました'),
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
                            )
                          ],
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff0C4842),
                          ),
                          label: Text('メールを送る',
                              style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xffFCFAF2))),
                          icon: const Icon(FeatherIcons.mail),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.black54,
                                  title: Text('メールを送りますか？',
                                      style: GoogleFonts.sawarabiMincho(
                                          color: const Color(0xffFCFAF2))),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                            model.openMailApp(
                                                uid,
                                                auth.currentUser!.email
                                                    .toString());
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
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                              '※メールアプリがお使いのデバイスにインストールされていない場合は、ユーザー情報を記載し、以下のメールアドレスにPCや他のデバイスからご連絡ください',
                              style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xff43341B))),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('9channeru@gmail.com',
                                style: GoogleFonts.sawarabiMincho(
                                    color: const Color(0xff43341B))),
                            IconButton(
                                onPressed: () async {
                                  const data = ClipboardData(
                                      text: '9channeru@gmail.com');
                                  await Clipboard.setData(data);
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            '9ちゃんねるのメールアドレスをコピーしました'),
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
                                icon: const Icon(FeatherIcons.copy,
                                    color: Color(0xff43341B)))
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xffD0104C),
                          ),
                          label: Text('退会手続き',
                              style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xffFCFAF2))),
                          icon: const Icon(FeatherIcons.trash2),
                          onPressed: () async {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.black54,
                                  title: Column(
                                    children: [
                                      Text('アカウントを削除しますか？',
                                          style: GoogleFonts.sawarabiMincho(
                                              color: const Color(0xffFCFAF2))),
                                      const SizedBox(height: 10),
                                      Text('※削除後は二度とアカウントの復旧はできません',
                                          style: GoogleFonts.sawarabiMincho(
                                              color: const Color(0xffFCFAF2),
                                              fontSize: 15)),
                                    ],
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          child: Text('いいえ',
                                              style: GoogleFonts.sawarabiMincho(
                                                  color:
                                                      const Color(0xff33A6B8),
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('削除する',
                                              style: GoogleFonts.sawarabiMincho(
                                                  color:
                                                      const Color(0xff33A6B8),
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: () async {
                                            try {
                                              await model.deleteAccount(
                                                  context, adInterstitial);
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Login(
                                                          adInterstitial:
                                                              adInterstitial)));
                                            } catch (e) {
                                              await showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.black54,
                                                    title: Column(
                                                      children: [
                                                        Text(
                                                            'エラーが発生しました。\n一度ログインをし直して、再度削除を実行してください',
                                                            style: GoogleFonts
                                                                .sawarabiMincho(
                                                                    color: const Color(
                                                                        0xffFCFAF2),
                                                                    fontSize:
                                                                        15)),
                                                      ],
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          TextButton(
                                                            child: Text('ログアウト',
                                                                style: GoogleFonts.sawarabiMincho(
                                                                    color: const Color(
                                                                        0xff33A6B8),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            onPressed:
                                                                () async {
                                                              try {
                                                                auth.signOut();
                                                              } catch (e) {
                                                                GoogleSignIn()
                                                                    .signOut();
                                                              }
                                                              auth.signOut();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              await Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          Login(
                                                                              adInterstitial: adInterstitial)));
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  );
                                                },
                                              );
                                            }
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
                      ],
                    ),
                  )
                ],
              ),
            );
          });
        });
  }
}
