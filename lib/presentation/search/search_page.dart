// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:app_55hz/domain/thread.dart';
import 'package:app_55hz/main.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/search/search_model.dart';
import 'package:app_55hz/presentation/talk/talk_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key, this.thread, this.uid, this.searchWord})
      : super(key: key);
  AdInterstitial adInterstitial;
  Thread thread;
  String uid;
  String searchWord;
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final Size size =
        MediaQuery.of(context).size; // AutomaticKeepAliveClientMixin
    return ChangeNotifierProvider.value(
      value: SearchModel()
        ..getSearchPost(widget.thread, widget.searchWord)
        ..fetchBlockList(widget.uid),
      child: Scaffold(
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
                model.getMoreSearchPost(widget.thread, widget.searchWord);
              }
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      adInterstitial.counter++;
                      await model.getSearchPost(
                          widget.thread, widget.searchWord);
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
                        SizedBox(
                          height: size.height * 0.8,
                          width: size.width * 0.97,
                          child: ListView.builder(
                            controller: scrollController..addListener(getMore),
                            itemCount: posts.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final postUid = posts[index].uid.substring(20);
                              return Card(
                                  elevation: 9,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  color: const Color(0xff78C2C4),
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
                                                    Color(0xff78C2C4),
                                                    BlendMode.modulate)),
                                          ),
                                          child: ListTile(
                                            // contentPadding: const EdgeInsets.all(5),
                                            title: Container(
                                                child: blockUsers
                                                        .first.blockUsers
                                                        .contains(posts[index]
                                                            .uid
                                                            .substring(20))
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 17),
                                                        child: Text(
                                                            'ブロックしているユーザの投稿',
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
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
                                                                        .bold)),
                                                      )
                                                    : Padding(
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
                                                      )),
                                            subtitle: Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    if (posts[index].uid !=
                                                        widget.uid) {
                                                      blockUsers
                                                              .first.blockUsers
                                                              .contains(posts[
                                                                      index]
                                                                  .uid
                                                                  .substring(
                                                                      20))
                                                          ? unBlockDialog(
                                                              context,
                                                              widget.uid,
                                                              posts[index]
                                                                  .uid
                                                                  .substring(
                                                                      20),
                                                              model)
                                                          : blockDialog(
                                                              context,
                                                              widget.uid,
                                                              posts[index]
                                                                  .uid
                                                                  .substring(
                                                                      20),
                                                              model);
                                                    }
                                                  },
                                                  child: Text('  ID : $postUid',
                                                      style: GoogleFonts
                                                          .sawarabiMincho(
                                                              color: const Color(
                                                                  0xffFCFAF2),
                                                              fontSize: 12.0)),
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
                                            trailing: posts[index].uid !=
                                                    widget.uid
                                                ? IconButton(
                                                    icon: const Icon(
                                                        Feather.alert_triangle),
                                                    onPressed: () async {
                                                      await badAdd(
                                                          model,
                                                          context,
                                                          posts[index]
                                                              .documentID);
                                                    })
                                                : IconButton(
                                                    icon: const Icon(
                                                        Feather.trash),
                                                    onPressed: () async {
                                                      await deleteMyThread(
                                                          model,
                                                          context,
                                                          posts[index]
                                                              .documentID);
                                                    }),
                                            onTap: () async {
                                              if (blockUsers.first.blockUsers
                                                  .contains(posts[index]
                                                      .uid
                                                      .substring(20))) {
                                                blockThreadDialog(context);
                                              } else {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TalkPage(
                                                              threadID: widget
                                                                  .thread
                                                                  .documentID,
                                                              postID: posts[
                                                                      index]
                                                                  .documentID,
                                                              title:
                                                                  posts[index]
                                                                      .title,
                                                              uid: widget.uid,
                                                            )));
                                              }
                                            },
                                          ),
                                        )
                                      : ListTile(
                                          title: Text('不適切な投稿のため非表示にしました',
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.clip,
                                              style: GoogleFonts.sawarabiMincho(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xff43341B),
                                                fontSize: 18.0,
                                              ))));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
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
                    model.badAdd(widget.thread, postDocID, widget.uid);
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
                    model.deleteMyThread(widget.thread, postDcouID);
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
          title: Text('ブロックしてるユーザーの投稿のため表示できません',
              style:
                  GoogleFonts.sawarabiMincho(color: const Color(0xffFCFAF2))),
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
