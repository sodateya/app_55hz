import 'package:app_55hz/domain/thread.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/list/single_thread.dart';
import 'package:app_55hz/presentation/list/today_thread.dart';
import 'package:flutter/material.dart';
import 'all_thread.dart';

// ignore: must_be_immutable
class ListPage extends StatefulWidget {
  ListPage(
      {super.key,
      required this.thread,
      required this.uid,
      required this.sort,
      required this.adInterstitial,
      required this.threadList,
      required this.resSort});
  AdInterstitial adInterstitial;
  Thread thread;
  String uid;
  String sort;
  List<Thread> threadList;
  bool resSort;

  @override
  // ignore: library_private_types_in_public_api
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
        backgroundColor: const Color(0xffFCFAF2),
        body: Container(
          child: (() {
            switch (widget.thread.title) {
              case 'すべて':
                return AllThread(
                    thread: widget.thread,
                    sort: widget.sort,
                    uid: widget.uid,
                    adInterstitial: widget.adInterstitial,
                    threadList: widget.threadList,
                    resSort: widget.resSort);

              case '今日のトピック':
                return TodayThread(
                    thread: widget.thread,
                    sort: widget.sort,
                    uid: widget.uid,
                    adInterstitial: widget.adInterstitial,
                    threadList: widget.threadList,
                    resSort: widget.resSort);

              default:
                return ThreadList(
                    thread: widget.thread,
                    sort: widget.sort,
                    uid: widget.uid,
                    adInterstitial: widget.adInterstitial,
                    resSort: widget.resSort);
            }
          })(),
        ));
  }
}
