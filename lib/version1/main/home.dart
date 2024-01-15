// ignore_for_file: must_be_immutable, missing_return

import 'package:app_55hz/version1/domain/thread.dart';
import 'package:app_55hz/version1/main/admob.dart';
import 'package:app_55hz/version1/presentation/list/list_model.dart';
import 'package:app_55hz/version1/presentation/list/list_page.dart';
import 'package:app_55hz/version1/presentation/search/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'default_drawer.dart';

AdInterstitial? adInterstitial;

class Home extends StatelessWidget {
  FirebaseAuth auth;
  String uid;
  AdInterstitial adInterstitial;

  Home(
      {super.key,
      required this.auth,
      required this.uid,
      required this.adInterstitial});

  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<ListModel>(
      create: (context) => ListModel()
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
                    resSort: model.resSort!,
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
                      icon: const Icon(FeatherIcons.user),
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
                    IconButton(
                        onPressed: () async {
                          if (adInterstitial.ready == false) {
                            await adInterstitial.createAdforSerch();
                          }
                          adInterstitial.showAdforSerch(showDialog(
                              context: context,
                              builder: (context) {
                                return SearchDialog(
                                  adInterstitial: adInterstitial,
                                  uid: uid,
                                );
                              }));
                        },
                        icon: const Icon(FeatherIcons.search)),
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
}

class SearchDialog extends StatefulWidget {
  SearchDialog({super.key, required this.adInterstitial, required this.uid});

  TextEditingController con = TextEditingController();
  // final Function(String) onResult;
  AdInterstitial adInterstitial;
  String uid;
  @override
  _SearchDialogState createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextField(
        controller: widget.con,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: '検索ワード',
        ),
      ),
      actions: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('閉じる')),
                TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchPage(
                                    adInterstitial: widget.adInterstitial,
                                    uid: widget.uid,
                                    searchWord: widget.con.text,
                                  )));
                    },
                    child: const Text('検索')),
              ],
            ),
          ],
        )
      ],
    );
  }
}
