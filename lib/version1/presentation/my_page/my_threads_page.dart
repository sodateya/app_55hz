// ignore_for_file: missing_return

import 'package:app_55hz/version1/main/admob.dart';
import 'package:app_55hz/version1/presentation/talk/talk_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'my_threads_model.dart';

// ignore: must_be_immutable
class MyThreadsPage extends StatelessWidget {
  String uid;
  String sort;
  AdInterstitial adInterstitial;
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();

  MyThreadsPage(
      {super.key,
      required this.uid,
      required this.adInterstitial,
      required this.sort});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<MyThreadsModel>(
      create: (context) => MyThreadsModel()
        ..getConfig()
        ..getMyPost(uid, sort),
      child: Consumer<MyThreadsModel>(builder: (context, model, child) {
        final posts = model.posts;
        sort = model.timeSort;
        ScrollController scrollController = ScrollController();
        void getMore() async {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            model.getMoreMyPost(uid, sort);
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
                    Color(0xffBA9132),
                    BlendMode.modulate,
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    await model.changeTime().then((value) async {
                      await model.getMyPost(uid, value);
                    });
                  },
                  icon: const Icon(Icons.history)),
            ],
            title: Column(
              children: [
                const Text(
                  'マイページ',
                  style: TextStyle(
                    color: Color(0xffFCFAF2),
                    fontSize: 25.0,
                  ),
                ),
                Container(
                    width: size.width * 0.5,
                    color: const Color(0xffFCFAF2),
                    alignment: Alignment.center,
                    child: sort == 'createdAt'
                        ? const Text('投稿順',
                            style: TextStyle(
                                color: Color(0xffBA9132),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold))
                        : const Text(
                            '更新順',
                            style: TextStyle(
                                color: Color(0xffBA9132),
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold),
                          ))
              ],
            ),
            backgroundColor: const Color(0xffBA9132),
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
                          await model.getMyPost(uid, sort);
                        },
                        child: SizedBox(
                          height: size.height * 0.8,
                          width: size.width * 0.97,
                          child: ListView.builder(
                            controller: scrollController..addListener(getMore),
                            itemCount: posts.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                  elevation: 9,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                          image:
                                              AssetImage('images/washi1.png'),
                                          fit: BoxFit.fill,
                                          colorFilter: ColorFilter.mode(
                                              Color(0xffEFBB24),
                                              BlendMode.modulate)),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        posts[index].title!,
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Color(0xff43341B),
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: IconButton(
                                          icon: const Icon(FeatherIcons.trash),
                                          onPressed: () async {
                                            await deleteMyThread(
                                                model,
                                                context,
                                                posts[index].threadId,
                                                posts[index].documentID);
                                          }),
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => TalkPage(
                                              uid: uid,
                                              adInterstitial: adInterstitial,
                                              post: posts[index],
                                              resSort: model.resSort!,
                                            ),
                                          ),
                                        );
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

  Future deleteMyThread(
      MyThreadsModel model, BuildContext context, threadID, postID) async {
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
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('はい'),
                  onPressed: () async {
                    await model.deleteMyThread(threadID, postID);
                    // ignore: use_build_context_synchronously
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
}
