// ignore_for_file: must_be_immutable, missing_return

import 'package:app_55hz/domain/thread.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/list/list_model.dart';
import 'package:app_55hz/presentation/list/list_page.dart';
import 'package:app_55hz/presentation/search/search_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'default_drawer.dart';

class Home extends StatelessWidget {
  FirebaseAuth auth;
  String uid;
  AdInterstitial adInterstitial;

  Home({Key key, this.auth, this.uid, this.adInterstitial}) : super(key: key);
  TextEditingController searchController;

  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId,
    request: const AdRequest(),
  )..load();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: ListModel()
        ..checkMyBD(uid)
        ..getToken(uid)
        ..fetchThread(uid)
        ..setConfig()
        ..getConfig()
        ..upLoadUdid(uid)
        ..fetchVersion(context)
        ..resetBadge(),
      child: Consumer<ListModel>(
        builder: (context, model, child) {
          final sort = model.timeSort;
          final threads = model.threads;
          final tab = threads
              .map((Thread thread) => Tab(
                    text: thread.title,
                  ))
              .toList();
          final listPage = threads
              .map((Thread thread) => ListPage(
                    thread: thread,
                    uid: uid,
                    sort: sort,
                    adInterstitial: adInterstitial,
                    threadList: model.threads,
                  ))
              .toList();

          return DefaultTabController(
            length: tab.length,
            child: Scaffold(
                backgroundColor: const Color(0xffFCFAF2),
                drawer: DefaultDrawer(
                  uid: uid,
                  auth: auth,
                  model: model,
                  sort: sort,
                ),
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
                  leading: Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(Feather.user),
                      onPressed: () async {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }),
                  actions: [
                    IconButton(
                        onPressed: () async {
                          await model.changeTime();
                        },
                        icon: const Icon(Icons.history)),
                    // IconButton(
                    //     onPressed: () async {
                    //       await searchThread(context);
                    //     },
                    //     icon: const Icon(Feather.search)),
                  ],
                  title: Column(
                    children: [
                      Text(
                        '9ちゃんねる',
                        style: GoogleFonts.sawarabiMincho(
                          color: const Color(0xffFCFAF2),
                          fontSize: 25.0,
                        ),
                      ),
                      Container(
                          width: size.width * 0.5,
                          color: const Color(0xffFCFAF2),
                          alignment: Alignment.center,
                          child: sort == 'createdAt'
                              ? Text('投稿順',
                                  style: GoogleFonts.sawarabiMincho(
                                      color: const Color(0xff616138),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold))
                              : Text(
                                  '更新順',
                                  style: GoogleFonts.sawarabiMincho(
                                      color: const Color(0xff616138),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold),
                                ))
                    ],
                  ),
                  backgroundColor: const Color(0xff616138),
                  centerTitle: true,
                  bottom: TabBar(
                      tabs: tab,
                      isScrollable: true,
                      labelStyle: GoogleFonts.sawarabiMincho(
                          fontSize: 14.0, fontWeight: FontWeight.bold)),
                ),
                body: TabBarView(children: listPage),
                bottomNavigationBar: child),
          );
        },
        child: SizedBox(
          height: 64,
          child: AdWidget(
            ad: banner,
          ),
        ),
      ),
    );
  }

  Future searchThread(BuildContext context) {
    String searchWord;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xffFCFAF2),
          content: SizedBox(
            height: 250,
            width: 300,
            child: Column(
              children: [
                Text('検索ワードを入力してください',
                    style: GoogleFonts.sawarabiMincho(
                        color: const Color(0xff43341B))),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: TextFormField(
                      controller: searchController,
                      onChanged: (String value) => searchWord = value,
                      decoration: InputDecoration(
                        labelText: '検索ワード',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(color: Color(0xff43341B)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide:
                              const BorderSide(color: Color(0xff33A6B8)),
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                '閉じる',
                                style: GoogleFonts.sawarabiMincho(
                                    color: const Color(0xff33A6B8),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold),
                              )),
                          // TextButton(
                          //     onPressed: () async {
                          //       if (searchWord != null) {
                          //         Navigator.of(context).pop();
                          //         await Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) => SearchTabPage(
                          //                       uid: uid,
                          //                       searchWord: searchWord,
                          //                     )));
                          //         print(searchWord);
                          //       } else {
                          //         showDialog(
                          //             context: context,
                          //             builder: (BuildContext context) {
                          //               return AlertDialog(
                          //                 backgroundColor:
                          //                     const Color(0xffFCFAF2),
                          //                 title: Text(
                          //                   ' 検索ワードを入力してください',
                          //                   style: GoogleFonts.sawarabiMincho(
                          //                     color: const Color(0xff43341B),
                          //                     fontSize: 17,
                          //                   ),
                          //                 ),
                          //                 content: Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.end,
                          //                   children: [
                          //                     TextButton(
                          //                         onPressed: () async {
                          //                           Navigator.of(context).pop();
                          //                         },
                          //                         child: Text(
                          //                           '閉じる',
                          //                           style: GoogleFonts
                          //                               .sawarabiMincho(
                          //                             color: const Color(
                          //                                 0xff43341B),
                          //                             fontSize: 15.0,
                          //                           ),
                          //                         ))
                          //                   ],
                          //                 ),
                          //               );
                          //             });
                          //       }
                          //     },
                          //     child: Text(
                          //       '検索',
                          //       style: GoogleFonts.sawarabiMincho(
                          //           color: const Color(0xff33A6B8),
                          //           fontSize: 15.0,
                          //           fontWeight: FontWeight.bold),
                          //     )),
                        ],
                      ),
                      TextButton(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      backgroundColor: const Color(0xffFCFAF2),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                              '〜検索に関する注意事項〜',
                                              style: GoogleFonts.sawarabiMincho(
                                                  color:
                                                      const Color(0xff33A6B8),
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '現在使用しているサーバーの都合上、検索方法が少々複雑となっております',
                                              style: GoogleFonts.sawarabiMincho(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '内容',
                                                  style: GoogleFonts
                                                      .sawarabiMincho(
                                                    fontSize: 18.0,
                                                    color:
                                                        const Color(0xff33A6B8),
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '入力した検索ワードから始まるスレッドが検索結果として表示される仕様となっております',
                                              style: GoogleFonts.sawarabiMincho(
                                                  fontSize: 13.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '例',
                                                  style: GoogleFonts
                                                      .sawarabiMincho(
                                                          fontSize: 18.0,
                                                          color: const Color(
                                                              0xff33A6B8),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '検索ワード : 9ちゃんねる',
                                                  style: GoogleFonts
                                                      .sawarabiMincho(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '9ちゃんねるへようこそ!! ← 検索可能',
                                                  style: GoogleFonts
                                                      .sawarabiMincho(
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ようこそ!!9ちゃんねるへ ← 検索不可能',
                                                  style: GoogleFonts
                                                      .sawarabiMincho(
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            Text(
                                              '機能が改善されましたら速やかにアップデート致しますので、ご迷惑おかけしますがよろしくお願いいたします',
                                              style: GoogleFonts.sawarabiMincho(
                                                fontSize: 13.0,
                                              ),
                                            ),
                                            const Text('m(_ _ )m'),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                      '閉じる',
                                                      style: GoogleFonts
                                                          .sawarabiMincho(
                                                        color: const Color(
                                                            0xff43341B),
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ));
                                });
                          },
                          child: Text('※検索に関する注意事項',
                              style: GoogleFonts.sawarabiMincho(
                                color: const Color(0xffD0104C),
                                fontSize: 15.0,
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
