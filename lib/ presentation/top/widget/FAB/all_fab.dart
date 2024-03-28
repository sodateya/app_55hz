import 'package:app_55hz/%20presentation/admob/provider/interstitial/interstitial_9ch_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/threads_list_provider.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllFab extends ConsumerWidget {
  const AllFab({super.key, required this.thread});
  final Thread thread;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: FloatingActionButton.extended(
          elevation: 9,
          heroTag: thread.title,
          backgroundColor: const Color(0xff0C4842).withOpacity(0.7),
          label: const Row(children: [
            Text('スレを建てる',
                style: TextStyle(
                    color: Color(0xffFCFAF2),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold)),
            Icon(FeatherIcons.edit, color: Color(0xffFCFAF2))
          ]),
          onPressed: () {
            final threads = ref.watch(threadsListProvider).value;
            showBottomSheet(context, threads!);
            ref.read(interstitial9chProvider.notifier).createAd();
          }),
    );
  }
}

Future showBottomSheet(BuildContext context, List<Thread> threadList) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        backgroundColor: Colors.transparent,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0), // 角丸の半径を設定

              image: const DecorationImage(
                colorFilter: ColorFilter.mode(
                  Color(0xffFCFAF2),
                  BlendMode.dstATop,
                ),
                image: AssetImage('images/washi1.png'),
                fit: BoxFit.fill,
              ),
            ),
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('板選択',
                          style: TextStyle(
                              color: Color(0xff43341B),
                              fontSize: 21.0,
                              fontWeight: FontWeight.bold)),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        for (var thread in threadList) ...{
                          thread.title == 'すべて' || thread.title == '今日のトピック'
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ActionChip(
                                      onPressed: () async {
                                        await context
                                            .push(
                                          '${RouteConfig.top.path}/${RouteConfig.addPost.path}/${thread.documentID}/${thread.title}',
                                        )
                                            .then((value) {
                                          if (value != null) {
                                            value as Post;
                                            context.push(
                                                '${RouteConfig.top.path}/${RouteConfig.talk.path}/${value.uid}/${value.threadId}/${value.documentID}',
                                                extra: [value.title, true]);
                                          }
                                        });
                                      },
                                      backgroundColor: const Color(0xff939650),
                                      label: Text('${thread.title}板',
                                          style:
                                              const TextStyle(fontSize: 16.0))),
                                ),
                        }
                      ],
                    ),
                  )),
                ],
              ),
            ),
          )
        ],
      );
    },
  );
}
