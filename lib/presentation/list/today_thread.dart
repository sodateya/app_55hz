// ignore_for_file: must_be_immutable, missing_return, use_build_context_synchronously

import 'package:app_55hz/domain/thread.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../list/list_model.dart';
import '../talk/talk_page.dart';

class TodayThread extends StatelessWidget {
  Thread thread;
  String sort;
  String uid;
  AdInterstitial adInterstitial;
  TodayThread({Key key, this.thread, this.sort, this.uid, this.adInterstitial})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: ListModel()
        ..getUpdateToday(thread, sort)
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
                model.getMoreUpDateToday(thread, sort);
              }
            }

            return Stack(
              children: [
                GestureDetector(
                  child: Center(
                      child: Container(
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
                  )),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          adInterstitial.counter++;
                          await model.getUpdateToday(thread, sort);
                        },
                        child: SizedBox(
                          height: size.height,
                          child: ListView.builder(
                              controller: scrollController
                                ..addListener(getMore),
                              itemCount: posts.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final postUid = posts[index].uid.substring(20);
                                return posts[index].accessBlock.contains(uid) ||
                                        blockUsers.contains(posts[index].uid)
                                    ? const SizedBox()
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
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Color(0xff939650),
                                                              BlendMode
                                                                  .modulate)),
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
                                                                alignment:
                                                                    Alignment
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
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 3.0,
                                                                      right: 2),
                                                                  child: Text(
                                                                      'new',
                                                                      style: GoogleFonts.sawarabiMincho(
                                                                          textStyle: Theme.of(context)
                                                                              .textTheme
                                                                              .headline4,
                                                                          color: const Color(
                                                                              0xffFCFAF2),
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight:
                                                                              FontWeight.bold)),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                    ListTile(
                                                      title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 17,
                                                                bottom: 10),
                                                        child: Text(
                                                          posts[index].title,
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: GoogleFonts.sawarabiMincho(
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
                                                                  MaterialStateProperty.all(
                                                                      EdgeInsets
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
                                                                style: GoogleFonts.sawarabiMincho(
                                                                    color: const Color(
                                                                        0xffFCFAF2),
                                                                    fontSize:
                                                                        12.0)),
                                                          ),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            '${posts[index].createdAt.year}/${posts[index].createdAt.month}/${posts[index].createdAt.day} ${posts[index].createdAt.hour}:${posts[index].createdAt.minute}:${posts[index].createdAt.second}.${posts[index].createdAt.millisecond}',
                                                            style: GoogleFonts
                                                                .sawarabiMincho(
                                                                    color: const Color(
                                                                        0xff43341B),
                                                                    fontSize:
                                                                        10.0),
                                                          ),
                                                        ],
                                                      ),
                                                      trailing: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
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
                                                                builder:
                                                                    (context) {
                                                                  return TalkPage(
                                                                    threadID: posts[
                                                                            index]
                                                                        .threadId,
                                                                    postID: posts[
                                                                            index]
                                                                        .documentID,
                                                                    title: posts[
                                                                            index]
                                                                        .title,
                                                                    uid: uid,
                                                                    threadUid:
                                                                        posts[index]
                                                                            .uid,
                                                                    resSort: model
                                                                        .resSort,
                                                                    adInterstitial:
                                                                        adInterstitial,
                                                                    upDateAt: posts[
                                                                            index]
                                                                        .upDateAt,
                                                                    post: posts[
                                                                        index],
                                                                  );
                                                                }));
                                                        await model.setConfig();
                                                        if (posts[index]
                                                            .read
                                                            .contains(
                                                                uid.substring(
                                                                    20))) {
                                                        } else {
                                                          await model
                                                              .addReadforAll(
                                                                  posts[index]
                                                                      .threadId,
                                                                  posts[index]
                                                                      .documentID,
                                                                  uid.substring(
                                                                      20));
                                                        }
                                                      },
                                                      onLongPress: () async {
                                                        if (posts[index]
                                                                .documentID ==
                                                            uid) {
                                                          await deleteMyThread(
                                                              model,
                                                              context,
                                                              posts[index]
                                                                  .threadId,
                                                              posts[index]
                                                                  .documentID);
                                                        } else {
                                                          badAdd(
                                                              model,
                                                              context,
                                                              posts[index]
                                                                  .threadId,
                                                              posts[index]
                                                                  .documentID);
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : null);
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
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

  Future badAdd(ListModel model, BuildContext context, threadID, postID) {
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
                    await model.badAddforAll(threadID, postID, uid);
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

  Future deleteMyThread(
      ListModel model, BuildContext context, threadID, postID) {
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
                    await model.deleteMyThreadforAll(threadID, postID);
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