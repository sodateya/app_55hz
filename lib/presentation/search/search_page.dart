// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:app_55hz/domain/thread.dart';
import 'package:app_55hz/main.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/search/search_model.dart';
import 'package:app_55hz/presentation/talk/talk_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatelessWidget {
  AdInterstitial adInterstitial;
  String uid;
  String searchWord;

  SearchPage({Key key, this.adInterstitial, this.uid, this.searchWord})
      : super(key: key);
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId,
    request: const AdRequest(),
  )..load();

  @override
  Widget build(BuildContext context) {
    final Size size =
        MediaQuery.of(context).size; // AutomaticKeepAliveClientMixin
    return ChangeNotifierProvider<SearchModel>(
      create: (context) => SearchModel()
        ..searchAlgolia(searchWord, 0)
        ..fetchBlockList(uid),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage('images/washi1.png'),
            fit: BoxFit.cover,
            color: Color(0xff33A6B8),
            colorBlendMode: BlendMode.modulate,
          ),
          title: Text(
            '検索ワード : $searchWord',
            style: const TextStyle(
              color: Color(0xffFCFAF2),
              fontSize: 18.0,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        backgroundColor: const Color(0xffFCFAF2),
        body: SizedBox(
          width: size.width,
          child: Consumer<SearchModel>(builder: (context, model, child) {
            final posts = model.posts;
            final blockUsers = model.blockUser;
            ScrollController scrollController = ScrollController();
            void getMore() async {
              if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent) {
                adInterstitial.counter++;
                final page = model.search++;
                model.searchAlgolia(searchWord, page);
                // print('サーチ数 : ${model.search}');
              }
            }

            return model.isLoading
                ? const Center(child: Text('Now Loading'))
                : Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            model.posts = [];
                            adInterstitial.counter++;
                            model.search = 0;
                            model.searchAlgolia(searchWord, model.search);
                            // print('サーチ数 : ${model.search}');
                          },
                          child: Stack(
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.8,
                                    width: size.width * 0.97,
                                    child: model.posts.isEmpty
                                        ? Center(
                                            child: Text(
                                              '検索ワード\n「$searchWord」\nはヒットしませんでした',
                                              style: const TextStyle(
                                                  color: Color(0xff43341B)),
                                            ),
                                          )
                                        : ListView.builder(
                                            controller: scrollController
                                              ..addListener(getMore),
                                            itemCount: posts.length,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Card(
                                                  elevation: 9,
                                                  color:
                                                      const Color(0xff78C2C4),
                                                  child:
                                                      posts[index]
                                                                  .badCount
                                                                  .length <=
                                                              5
                                                          ? Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                image: const DecorationImage(
                                                                    image: AssetImage(
                                                                        'images/washi1.png'),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    colorFilter: ColorFilter.mode(
                                                                        Color(
                                                                            0xff78C2C4),
                                                                        BlendMode
                                                                            .modulate)),
                                                              ),
                                                              child: ListTile(
                                                                title: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8),
                                                                  child: Text(
                                                                    posts[index]
                                                                        .title,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xff43341B),
                                                                        fontSize:
                                                                            15.0,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                                subtitle: Row(
                                                                  children: [
                                                                    TextButton(
                                                                      style:
                                                                          ButtonStyle(
                                                                        padding:
                                                                            MaterialStateProperty.all(EdgeInsets.zero),
                                                                        minimumSize:
                                                                            MaterialStateProperty.all(Size.zero),
                                                                        tapTargetSize:
                                                                            MaterialTapTargetSize.shrinkWrap,
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        if (posts[index].uid !=
                                                                            uid) {
                                                                          blockUsers.first.blockUsers.contains(posts[index].uid.substring(20))
                                                                              ? unBlockDialog(context, uid, posts[index].uid.substring(20), model)
                                                                              : blockDialog(context, uid, posts[index].uid.substring(20), model);
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                          '  ID : ${posts[index].uid.substring(20)}',
                                                                          style: const TextStyle(
                                                                              color: Color(0xffFCFAF2),
                                                                              fontSize: 12.0)),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Text(
                                                                      model
                                                                          .formattedTime
                                                                          .format(
                                                                              posts[index].createdAt),
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0xff43341B),
                                                                          fontSize:
                                                                              10.0),
                                                                    ),
                                                                  ],
                                                                ),
                                                                onTap:
                                                                    () async {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder:
                                                                              (context) {
                                                                    return TalkPage(
                                                                      uid: uid,
                                                                      resSort: model
                                                                          .resSort,
                                                                      adInterstitial:
                                                                          adInterstitial,
                                                                      postAlgolia:
                                                                          posts[
                                                                              index],
                                                                    );
                                                                  }));
                                                                },
                                                              ))
                                                          : const SizedBox
                                                              .shrink());
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          }),
        ),
        bottomNavigationBar: SizedBox(
          height: 64,
          child: AdWidget(
            ad: banner,
          ),
        ),
      ),
    );
  }

  // ignore: missing_return
  Future badAdd(SearchModel model, BuildContext context, postDocID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('違反報告しますか？'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('いいえ'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('はい'),
                  onPressed: () {
                    // model.badAdd(widget.thread, postDocID, uid);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ignore: missing_return
  Future deleteMyThread(SearchModel model, BuildContext context, postDcouID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('投稿を削除しますか？'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('いいえ'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('はい'),
                  onPressed: () {
                    // model.deleteMyThread(thread, postDcouID);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ignore: missing_return
  Future blockDialog(
      BuildContext context, String uid, String blockUser, SearchModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('$blockUserをブロックしますか？',
              style: const TextStyle(color: Color(0xffFCFAF2))),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('いいえ'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('ブロックする'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await model.addToBlockList(uid, blockUser);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ignore: missing_return
  Future unBlockDialog(
      BuildContext context, String uid, String blockUser, SearchModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('$blockUserをブロック解除しますか？',
              style: const TextStyle(color: Color(0xffFCFAF2))),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('いいえ'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('解除する'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await model.removeToBlockList(uid, blockUser);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // ignore: missing_return
  Future blockThreadDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: const Text('ブロックしてるユーザーの投稿のため表示できません',
              style: TextStyle(color: Color(0xffFCFAF2))),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
