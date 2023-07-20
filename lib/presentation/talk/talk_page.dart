// ignore_for_file: must_be_immutable, use_build_context_synchronously, missing_return

import 'dart:math';
import 'package:app_55hz/domain/custom_cache_manager.dart';
import 'package:app_55hz/domain/post_algolia.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/talk/talk_model.dart';
import 'package:app_55hz/presentation/talk_add/talk_add_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../domain/post.dart';

class TalkPage extends StatelessWidget {
  String uid;
  AdInterstitial adInterstitial;
  bool resSort;
  Post? post;
  PostAlgolia? postAlgolia;
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();

  TalkPage({
    super.key,
    required this.uid,
    required this.resSort,
    required this.adInterstitial,
    this.post,
    this.postAlgolia,
  });

  int postCount = 0;

  @override
  Widget build(BuildContext context) {
    post ??= postAlgolia!.toPost();
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<TalkModel>(
      create: (context) => TalkModel()
        ..fetchMyFavorite(uid)
        ..getTalk(post!, resSort, uid)
        ..fetchBlockList(uid),
      child: Scaffold(
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
            backgroundColor: const Color(0xff616138),
            actions: [
              Consumer<TalkModel>(builder: (context, model, child) {
                final favoriteThreads = model.favoriteThread;
                return favoriteThreads.isNotEmpty
                    ? Row(
                        children: [
                          post!.uid == uid
                              ? IconButton(
                                  onPressed: () async {
                                    await model.getTalk(post!, resSort, uid);
                                    await showAccessBlockList(context, model);
                                  },
                                  icon: const Icon(FeatherIcons.userX))
                              : const Icon(null),
                          IconButton(
                              onPressed: () async {
                                await model.changeReverse().then((value) async {
                                  if (adInterstitial.ready == false) {
                                    adInterstitial.createAd();
                                  }
                                  adInterstitial.counter = 7;
                                });
                                await model.getTalk(post!, resSort, uid);
                              },
                              icon: Transform.rotate(
                                  angle: 90 * pi / 180,
                                  child: const Icon(FeatherIcons.repeat))),
                          IconButton(
                              onPressed: () async {
                                if (favoriteThreads.first.favoriteThreads!
                                    .contains(
                                        post!.documentID!.substring(10))) {
                                  await model.deleteFavorite(uid, post!);
                                } else {
                                  await model.addFavorite(uid, post!);
                                }
                              },
                              icon: favoriteThreads.first.favoriteThreads!
                                      .contains(post!.documentID!.substring(10))
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Color(0xffD0104C),
                                    )
                                  : const Icon(Icons.favorite_border))
                        ],
                      )
                    : const Icon(null);
              })
            ],
            title: Text(post!.title!,
                style:
                    const TextStyle(color: Color(0xffFCFAF2), fontSize: 16))),
        backgroundColor: const Color(0xffFCFAF2),
        body: Consumer<TalkModel>(builder: (context, model, child) {
          final talks = model.talks;
          ScrollController scrollController = ScrollController();
          Future getMore() async {
            if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
              adInterstitial.counter++;
              await model.getMoreTalk(post!);
            }
          }

          return Stack(
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
              Column(
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        adInterstitial.counter++;
                        await model.getTalk(post!, resSort, uid);
                      },
                      child: ListView.builder(
                        cacheExtent: 9999,
                        controller: scrollController..addListener(getMore),
                        itemCount: talks.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final blockUsers = model.blockUser;
                          if (postCount < talks[index].count!) {
                            postCount = talks[index].count!;
                          }
                          if (talks[index].badCount!.length >= 5 ||
                              blockUsers.contains(talks[index].uid)) {
                            return const SizedBox.shrink();
                          } else {
                            return Slidable(
                              actionPane: const SlidableBehindActionPane(),
                              secondaryActions: [
                                post!.uid == uid && talks[index].uid != uid
                                    ? IconSlideAction(
                                        color: const Color(0xffFCFAF2),
                                        caption: 'アクブロ',
                                        onTap: () async {
                                          await model.deleteFavorite(
                                              talks[index].uid!, post!);
                                          await model.addAccsessBlock(context,
                                              post!, talks[index].uid!);
                                        },
                                        icon: FeatherIcons.userX,
                                      )
                                    : const SizedBox(width: 0.1),
                                talks[index].uid == uid
                                    ? IconSlideAction(
                                        color: const Color(0xffFCFAF2),
                                        caption: '削除',
                                        onTap: () {
                                          deleteAdd(
                                              model, context, talks[index]);
                                        },
                                        icon: FeatherIcons.trash,
                                      )
                                    : IconSlideAction(
                                        color: const Color(0xffFCFAF2),
                                        caption: '報告',
                                        onTap: () {
                                          badAdd(model, context, talks[index]);
                                        },
                                        icon: FeatherIcons.alertTriangle,
                                      ),
                              ],
                              child: Container(
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            color: Color(0xff43341B)))),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 7),
                                            TextButton(
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      MaterialStateProperty.all(
                                                          Size.zero),
                                                  tapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                ),
                                                child: Text(
                                                  talks[index].count.toString(),
                                                  style: const TextStyle(
                                                    color: Color(0xff43341B),
                                                  ),
                                                ),
                                                onPressed: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddTalkPage(
                                                              post: post!,
                                                              uid: uid,
                                                              resNumber: talks[
                                                                      index]
                                                                  .count
                                                                  .toString(),
                                                              count: postCount,
                                                            ),
                                                        fullscreenDialog: true),
                                                  );
                                                }),
                                            const Text(
                                              ':',
                                              style: TextStyle(
                                                color: Color(0xff43341B),
                                              ),
                                            ),
                                            SizedBox(
                                              width: size.width * 0.31,
                                              child: Text(
                                                  talks[index].name! == ""
                                                      ? '名無しさん'
                                                      : talks[index].name!,
                                                  style: const TextStyle(
                                                      color:
                                                          Color(0xff43341B))),
                                            ),
                                            Text(
                                                '${talks[index].createdAt!.year}/${talks[index].createdAt!.month}/${talks[index].createdAt!.day} ${talks[index].createdAt!.hour}:${talks[index].createdAt!.minute}:${talks[index].createdAt!.second}.${talks[index].createdAt!.millisecond}',
                                                style: const TextStyle(
                                                    color: Color(0xff43341B),
                                                    fontSize: 10.0),
                                                textAlign: TextAlign.left),
                                            talks[index].uid == post!.uid
                                                ? const Text(
                                                    '  (主)',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff2EA9DF),
                                                        fontSize: 8.0),
                                                  )
                                                : const SizedBox.shrink()
                                          ],
                                        ),
                                        TextButton(
                                          style: ButtonStyle(
                                            minimumSize:
                                                MaterialStateProperty.all(
                                                    Size.zero),
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                          ),
                                          child: Text(
                                            'ID:${talks[index].uid!.substring(20)}',
                                            style: const TextStyle(
                                                color: Color(0xff33A6B8),
                                                fontSize: 8),
                                          ),
                                          onPressed: () {
                                            blockDialog(
                                                context,
                                                uid,
                                                talks[index].uid!,
                                                model,
                                                blockUsers);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 12),
                                        SizedBox(
                                          width: size.width * 0.85,
                                          child: SelectableText(
                                            talks[index].comment!,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Color(0xff43341B),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width: 12),
                                        SizedBox(
                                            width: size.width * 0.85,
                                            child: talks[index].url == ""
                                                ? null
                                                : blockUsers.contains(
                                                        talks[index]
                                                            .uid!
                                                            .substring(20))
                                                    ? null
                                                    : RichText(
                                                        maxLines: 2,
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: talks[
                                                                          index]
                                                                      .url,
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Color(
                                                                        0xff33A6B8),
                                                                    fontSize:
                                                                        14.0,
                                                                  ),
                                                                  recognizer:
                                                                      TapGestureRecognizer()
                                                                        ..onTap =
                                                                            () async {
                                                                          if (await canLaunch(
                                                                              talks[index].url!)) {
                                                                            await launch(talks[index].url!);
                                                                          } else {
                                                                            try {
                                                                              await launch(talks[index].url!);
                                                                            } catch (e) {
                                                                              print('error');
                                                                              await errorDialog(context);
                                                                            }
                                                                          }
                                                                        })
                                                            ]))),
                                      ],
                                    ),
                                    Center(
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: size.width * 0.85,
                                          child: talks[index].imgURL == ''
                                              ? null
                                              : blockUsers.contains(talks[index]
                                                      .uid!
                                                      .substring(20))
                                                  ? null
                                                  : GestureDetector(
                                                      onTap: () async {
                                                        if (await canLaunch(
                                                            talks[index]
                                                                .imgURL!)) {
                                                          await launch(
                                                              talks[index]
                                                                  .imgURL!);
                                                        } else {
                                                          try {
                                                            await launch(
                                                                talks[index]
                                                                    .imgURL!);
                                                          } catch (e) {
                                                            print('error');
                                                            await errorDialog(
                                                                context);
                                                          }
                                                        }
                                                      },
                                                      child: CachedNetworkImage(
                                                        imageUrl: talks[index]
                                                            .imgURL!,
                                                        fit: BoxFit.fill,
                                                        cacheManager:
                                                            customCacheManager,
                                                        placeholder: (context,
                                                                url) =>
                                                            SizedBox(
                                                                child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            SizedBox(
                                                              width: 80,
                                                              height: 80,
                                                              child: Image(
                                                                image: AssetImage(
                                                                    'images/logo.gif'),
                                                              ),
                                                            ),
                                                            Text('〜読み込み中〜',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff43341B),
                                                                    fontSize:
                                                                        21)),
                                                          ],
                                                        )),
                                                      ))),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
        bottomNavigationBar: SizedBox(
          height: 64,
          child: AdWidget(
            ad: banner,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xff0C4842),
          child: const Icon(FeatherIcons.edit2),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTalkPage(
                  uid: uid,
                  post: post!,
                  count: postCount,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future badAdd(TalkModel model, BuildContext context, dynamic talk) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: const Text('違反報告しますか？',
              style: TextStyle(
                color: Color(0xffFCFAF2),
              )),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('いいえ',
                      style: TextStyle(
                          color: Color(0xff33A6B8),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('はい',
                      style: TextStyle(
                          color: Color(0xff33A6B8),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    await model.badAdd(post!, talk, uid);
                    Navigator.of(context).pop();
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            backgroundColor: Colors.black54,
                            title: Text('通報しました',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffFCFAF2),
                                )),
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future deleteAdd(TalkModel model, BuildContext context, dynamic talk) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: const Text(
            '投稿を削除しますか？',
            style: TextStyle(
                color: Color(0xffFCFAF2),
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('いいえ',
                      style: TextStyle(
                          color: Color(0xff33A6B8),
                          fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('はい',
                      style: TextStyle(
                          color: Color(0xff33A6B8),
                          fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    await model.deleteAdd(post!, talk);
                    Navigator.of(context).pop();
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            backgroundColor: Colors.black54,
                            title: Text('投稿を削除しました',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffFCFAF2),
                                )),
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future errorDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: const Text('URLが誤っているため\n表示できません',
              style: TextStyle(color: Color(0xffFCFAF2))),
          actions: [
            TextButton(
              child: const Text('閉じる'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future blockDialog(BuildContext context, String uid, String blockUser,
      TalkModel model, List blockUsers) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('${blockUser.substring(20)}をブロックしますか？',
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
                    await model.addToBlockList(uid, blockUser);
                    Navigator.of(context).pop();
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.black54,
                            title: Text('${blockUser.substring(20)}をブロックしました',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xffFCFAF2),
                                )),
                          );
                        });
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future showAccessBlockList(BuildContext context, TalkModel model) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (model.accessBlockList.isNotEmpty)
                  SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: model.accessBlockList.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            color: const Color(0xffFCFAF2),
                            child: ListTile(
                              title: Text(
                                  '${model.accessBlockList[index].toString().substring(20)}のアクセスブロックを解除',
                                  style: const TextStyle(
                                      color: Color(0xff43341B),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold)),
                              onTap: () async {
                                await model.removeAccsessBlock(context, post!,
                                    model.accessBlockList[index].toString());
                              },
                            ),
                          );
                        },
                      ))
                else
                  const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Text('ブロックしてるユーザーはいません',
                        style: TextStyle(
                            color: Color(0xffFCFAF2),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xff0C4842),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    child: const Text('閉じる',
                        style: TextStyle(
                            color: Color(0xffFCFAF2),
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        );
      },
    );
  }
}
