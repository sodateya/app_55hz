// ignore_for_file: must_be_immutable, missing_return, use_build_context_synchronously

import 'package:app_55hz/domain/thread.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../add_thread/add_thread_page.dart';
import '../list/list_model.dart';
import '../talk/talk_page.dart';

class ThreadList extends StatelessWidget {
  Thread thread;
  String sort;
  String uid;
  AdInterstitial adInterstitial;
  ThreadList({Key key, this.thread, this.sort, this.uid, this.adInterstitial})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: ListModel()
        ..getPost(thread, sort)
        ..fetchBlockList(uid),
      child: Scaffold(
        backgroundColor: const Color(0xffFCFAF2),
        body: SizedBox(
          width: size.width,
          child: Consumer<ListModel>(builder: (context, model, child) {
            final posts = model.posts;
            final blockUsers = model.blockUser;
            ScrollController scrollController = ScrollController();
            void getMore() async {
              if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent) {
                adInterstitial.counter++;
                model.getMorePost(thread, sort);
              }
            }

            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        const Color(0xffFCFAF2).withOpacity(0.4),
                        BlendMode.dstATop),
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
                          await model.getPost(thread, sort);
                        },
                        child: ListView.builder(
                          controller: scrollController..addListener(getMore),
                          itemCount: posts.length,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final postUid = posts[index].uid.substring(20);
                            return posts[index].accessBlock.contains(uid) ||
                                    blockUsers.contains(posts[index].uid)
                                ? const SizedBox.shrink()
                                : Card(
                                    elevation: 9,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    color: const Color(0xff939650),
                                    child: posts[index].badCount.length <= 5
                                        ? Container(
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
                                            child: Stack(
                                              children: [
                                                posts[index].read.contains(
                                                        uid.substring(20))
                                                    ? const SizedBox()
                                                    : Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .topRight,
                                                            width: 25,
                                                            height: 25,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffD0104C),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 3.0,
                                                                      right: 2),
                                                              child: Text('new',
                                                                  style: GoogleFonts.sawarabiMincho(
                                                                      textStyle: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline4,
                                                                      color: const Color(
                                                                          0xffFCFAF2),
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                ListTile(
                                                  title: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 17,
                                                            bottom: 10),
                                                    child: Text(
                                                      posts[index].title,
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: GoogleFonts
                                                          .sawarabiMincho(
                                                              textStyle: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline4,
                                                              color: const Color(
                                                                  0xff43341B),
                                                              fontSize: 15.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                  subtitle: Row(
                                                    children: [
                                                      TextButton(
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          minimumSize:
                                                              MaterialStateProperty
                                                                  .all(Size
                                                                      .zero),
                                                          tapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                        ),
                                                        onPressed: () {
                                                          if (posts[index]
                                                                  .uid !=
                                                              uid) {
                                                            blockDialog(
                                                                context,
                                                                uid,
                                                                posts[index]
                                                                    .uid,
                                                                model);
                                                          }
                                                        },
                                                        child: Text(
                                                            '  ID : $postUid',
                                                            style: GoogleFonts
                                                                .sawarabiMincho(
                                                                    color: const Color(
                                                                        0xffFCFAF2),
                                                                    fontSize:
                                                                        12.0)),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        '${posts[index].createdAt.year}/${posts[index].createdAt.month}/${posts[index].createdAt.day} ${posts[index].createdAt.hour}:${posts[index].createdAt.minute}:${posts[index].createdAt.second}.${posts[index].createdAt.millisecond}',
                                                        style: GoogleFonts
                                                            .sawarabiMincho(
                                                                color: const Color(
                                                                    0xff43341B),
                                                                fontSize: 10.0),
                                                      ),
                                                    ],
                                                  ),
                                                  trailing: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      model.isUpdateToday(
                                                              posts[index],
                                                              index)
                                                          ? Text(
                                                              '${posts[index].postCount.toString()}ｺﾒ/日',
                                                              style: GoogleFonts.sawarabiMincho(
                                                                  color: const Color(
                                                                      0xff43341B),
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          : Text('0ｺﾒ/日',
                                                              style: GoogleFonts.sawarabiMincho(
                                                                  color: const Color(
                                                                      0xff43341B),
                                                                  fontSize:
                                                                      13.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold))
                                                    ],
                                                  ),
                                                  onTap: () async {
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            maintainState:
                                                                false,
                                                            builder: (context) {
                                                              return TalkPage(
                                                                uid: uid,
                                                                resSort: model
                                                                    .resSort,
                                                                adInterstitial:
                                                                    adInterstitial,
                                                                post: posts[
                                                                    index],
                                                              );
                                                            }));
                                                    await model.addRead(
                                                        thread,
                                                        posts[index].documentID,
                                                        uid.substring(20));
                                                  },
                                                  onLongPress: () async {
                                                    if (posts[index].uid ==
                                                        uid) {
                                                      await deleteMyThread(
                                                          model,
                                                          context,
                                                          posts[index]
                                                              .documentID);
                                                    } else {
                                                      await badAdd(
                                                          model,
                                                          context,
                                                          posts[index]
                                                              .documentID);
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        : null);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
        floatingActionButton: Stack(
          children: [
            Consumer<ListModel>(builder: (context, model, child) {
              return FloatingActionButton.extended(
                heroTag: null,
                elevation: 9,
                label: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${thread.title}板',
                          style: GoogleFonts.sawarabiMincho(
                              textStyle: Theme.of(context).textTheme.headline4,
                              color: const Color(0xffFCFAF2),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'に追加',
                          style: GoogleFonts.sawarabiMincho(
                              textStyle: Theme.of(context).textTheme.headline4,
                              color: const Color(0xffFCFAF2),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(Feather.edit),
                  ],
                ),
                backgroundColor: const Color(0xff0C4842).withOpacity(0.7),
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddThreadPage(
                                thread: thread,
                                title: thread.title,
                                uid: uid,
                                adInterstitial: adInterstitial,
                                blockUsers: model.blockUser,
                              )));
                  adInterstitial.createAd();
                  await adInterstitial.showAd();
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  Future blockDialog(
      BuildContext context, String uid, String blockUser, ListModel model) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('${blockUser.substring(20)}をブロックしますか？',
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
                                style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xffFCFAF2),
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

  Future badAdd(ListModel model, BuildContext context, postDocID) {
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
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('はい'),
                  onPressed: () async {
                    await model.badAdd(thread, postDocID, uid);
                    Navigator.of(context).pop();
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.black54,
                            title: Text('通報しました',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xffFCFAF2),
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

  Future deleteMyThread(ListModel model, BuildContext context, postDcouID) {
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
                    await model.deleteMyThread(thread, postDcouID);
                    Navigator.of(context).pop();
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.black54,
                            title: Text('投稿を削除しました',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xffFCFAF2),
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
}
