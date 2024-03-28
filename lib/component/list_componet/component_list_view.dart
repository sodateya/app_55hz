import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/my_page/provider/my_post_list_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/bad_post_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/is_update_today_provider.dart';
import 'package:app_55hz/%20presentation/top/widget/body/list_tile_9ch.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/component/dialog_9ch.dart';
import 'package:app_55hz/component/get_more_button.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ComponentListView extends HookConsumerWidget {
  const ComponentListView(
      {super.key,
      required this.onRefresh,
      required this.getMoreMethod,
      required this.list,
      required this.tileColor,
      this.readMethod});
  final Future<void> Function() onRefresh;
  final void Function() getMoreMethod;
  final List<Post> list;
  final Color? tileColor;
  final Future<dynamic>? readMethod;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    return Stack(
      children: [
        const BackImg(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: onRefresh,
                child: SizedBox(
                  height: double.infinity,
                  child: ListView.builder(
                      itemCount: list.length + 1,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        final posts = list;

                        return i == list.length
                            ? GetMoreButton(onPressed: getMoreMethod)
                            : ListTile9ch(
                                isUpdateToday: ref.read(
                                    isUpdateTodayProvider(list[i].upDateAt!)),
                                color: tileColor,
                                posts: list[i],
                                onLongPressed: () {
                                  print(posts[i].documentID);
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        if (posts[i].uid == uid) {
                                          return Dialog9ch(
                                              title: 'この投稿を削除しますか？',
                                              buttonLabel: '削除',
                                              onPressed: () {
                                                ref
                                                    .read(myPostListProvider
                                                        .notifier)
                                                    .deleteMyThread(
                                                        list[i].threadId!,
                                                        list[i].documentID!);

                                                Navigator.pop(context);
                                              });
                                        } else {
                                          return Dialog9ch(
                                              title: 'この投稿を違反報告しますか？',
                                              buttonLabel: '報告する',
                                              onPressed: () {
                                                final notifier = ref.read(
                                                    badPostProvider.notifier);
                                                notifier.addBadPost(
                                                    posts[i].threadId!,
                                                    posts[i].documentID!,
                                                    posts[i].uid!);
                                                Navigator.pop(context);
                                              });
                                        }
                                      });
                                },
                                onPressed: () async {
                                  context.push(
                                      '${RouteConfig.top.path}/${RouteConfig.talk.path}/${list[i].uid}/${list[i].threadId}/${list[i].documentID}',
                                      extra: [
                                        list[i].title,
                                        ref.read(isUpdateTodayProvider(
                                            list[i].upDateAt!))
                                      ]);
                                  if (list[i]
                                      .read!
                                      .contains(uid.substring(20))) {
                                  } else {
                                    ref
                                        .read(myPostListProvider.notifier)
                                        .readPost(list[i], i);
                                  }
                                },
                              );
                      }),
                ),
              ),
            ),
          ],
        ),
        Container(
            alignment: Alignment.bottomCenter, child: const BannerWidget())
      ],
    );
  }
}
