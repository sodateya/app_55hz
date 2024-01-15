// ignore_for_file: must_be_immutable

import 'package:app_55hz/version1/main/admob.dart';
import 'package:app_55hz/version1/presentation/talk/talk_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'my_favorite_page_model.dart';

class MyFavoritePage extends StatelessWidget {
  String uid;
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();
  MyFavoritePage({super.key, required this.uid});

  @override
  AdInterstitial? adInterstitial;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MyFavoritePageModel>(
      create: (context) => MyFavoritePageModel()
        ..getResSort()
        ..getMyFavorite(uid)
        ..getBlockList(uid),
      child: Consumer<MyFavoritePageModel>(builder: (context, model, child) {
        final posts = model.myPost;
        ScrollController scrollController = ScrollController();
        void getMore() async {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            model.getMoreMyFavorite(uid);
          }
        }

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
              'お気に入り',
              style: GoogleFonts.sawarabiMincho(
                color: const Color(0xffFCFAF2),
                fontSize: 25.0,
              ),
            ),
            backgroundColor: const Color(0xff616138),
          ),
          backgroundColor: const Color(0xffFCFAF2),
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
              SizedBox(
                width: size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await model.getMyFavorite(uid);
                        },
                        child: SizedBox(
                          height: size.height * 0.8,
                          width: size.width * 0.97,
                          child: ListView.builder(
                            controller: scrollController..addListener(getMore),
                            itemCount: posts.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final blockUsers = model.blockList;

                              return blockUsers.contains(posts[index]
                                          .threadUid!
                                          .substring(20)) ==
                                      true
                                  ? const SizedBox()
                                  : Card(
                                      elevation: 9,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'images/washi1.png'),
                                              fit: BoxFit.fill,
                                              colorFilter: ColorFilter.mode(
                                                  Color(0xff939650),
                                                  BlendMode.modulate)),
                                        ),
                                        child: ListTile(
                                          // contentPadding: const EdgeInsets.all(5),
                                          title: Text(
                                            posts[index].title!,
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.clip,
                                            style: const TextStyle(
                                                color: Color(0xff43341B),
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold),
                                          ),

                                          onTap: () async {
                                            try {
                                              await model
                                                  .getThreadData(
                                                      posts[index].threadID!,
                                                      posts[index].postID!)
                                                  .then((value) =>
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              TalkPage(
                                                            uid: uid,
                                                            adInterstitial:
                                                                adInterstitial!,
                                                            post: value,
                                                            resSort:
                                                                model.resSort!,
                                                          ),
                                                        ),
                                                      ));
                                            } catch (e) {
                                              deleteFavoriteDialog(
                                                  context,
                                                  model,
                                                  uid,
                                                  posts[index].postID!);
                                            }
                                          },
                                        ),
                                      ));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 64,
            child: AdWidget(
              ad: banner,
            ),
          ),
        );
      }),
    );
  }

  Future deleteFavoriteDialog(BuildContext context, MyFavoritePageModel model,
      String uid, String documentID) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('このスレは削除されているためアクセスできません。\n\nリストから削除しますか？',
              style:
                  GoogleFonts.sawarabiMincho(color: const Color(0xffFCFAF2))),
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
                  child: const Text('削除する'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await model.deleteFavorite(uid, documentID);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
