import 'dart:math';

import 'package:app_55hz/%20presentation/block/provider/block_users_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/talk/provider/talk_list_provider.dart';
import 'package:app_55hz/%20presentation/talk/widget/access_block_dialog.dart';
import 'package:app_55hz/%20presentation/talk/widget/add_talk_fab.dart';
import 'package:app_55hz/%20presentation/talk/widget/favorite_mark.dart';
import 'package:app_55hz/%20presentation/talk/widget/talk_frame.dart';
import 'package:app_55hz/%20presentation/talk/widget/talk_tile/talk_tile.dart';
import 'package:app_55hz/component/get_more_button.dart';
import 'package:app_55hz/config/sort/res_sort_provider.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TalkPage extends HookConsumerWidget {
  const TalkPage(
      {super.key,
      required this.postUid,
      required this.postId,
      required this.threadId,
      required this.title,
      required this.isUpdateToday});
  final String postUid;
  final String postId;
  final String threadId;
  final String title;
  final bool isUpdateToday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(firebaseAuthInstanceProvider).currentUser!.uid;
    final talks = ref.watch(talkListProvider(postId, threadId));

    return talks.when(data: (talk) {
      List<Talk> talks = [];
      talks.addAll(talk.talks);
      ref.watch(blockUsersProvider).when(
          data: (data) {
            talks.retainWhere((element) => !data!.contains(element.uid));
          },
          error: (e, __) {},
          loading: () {});
      return TalkFrame(
        title: title,
        actions: [
          Row(
            children: [
              postUid == uid
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AccessBlockDialog(
                                  threadId: threadId, postId: postId);
                            });
                      },
                      icon: const Icon(FeatherIcons.userX))
                  : const Icon(null),
              IconButton(
                  onPressed: () async {
                    await ref.read(resSortProvider.notifier).changeResSort();
                    await ref
                        .read(talkListProvider(postId, threadId).notifier)
                        .getTalk(postId, threadId);
                  },
                  icon: Transform.rotate(
                      angle: 90 * pi / 180,
                      child: const Icon(FeatherIcons.repeat))),
              FavoriteMark(
                  postUid: postUid,
                  postId: postId,
                  threadId: threadId,
                  title: title)
            ],
          )
        ],
        body: Column(
          children: [
            Expanded(
                child: RefreshIndicator(
                    onRefresh: () async {
                      await ref
                          .read(talkListProvider(postId, threadId).notifier)
                          .getTalk(postId, threadId);
                    },
                    child: ListView.builder(
                        itemCount: talks.length + 1,
                        itemBuilder: (context, i) {
                          return i == talks.length
                              ? GetMoreButton(onPressed: () {
                                  ref
                                      .read(talkListProvider(postId, threadId)
                                          .notifier)
                                      .getMoreTalk(postId, threadId);
                                })
                              : Column(children: [
                                  TalkTile(
                                    talk: talks[i],
                                    postUid: postUid,
                                    postId: postId,
                                    threadId: threadId,
                                    countOnTaped: () async {
                                      final result = await context.push(
                                          '${RouteConfig.top.path}/${RouteConfig.addTalk.path}/${talks[i].count}/$postId/$threadId',
                                          extra: isUpdateToday);
                                      if (result != null) {
                                        await ref
                                            .read(talkListProvider(
                                                    postId, threadId)
                                                .notifier)
                                            .getTalk(postId, threadId);
                                      }
                                    },
                                  )
                                ]);
                        })))
          ],
        ),
        floatingActionButton: AddTalkFab(
          onPressed: () async {
            final result = await context.push(
                '${RouteConfig.top.path}/${RouteConfig.addTalk.path}/null/$postId/$threadId',
                extra: isUpdateToday);
            if (result != null) {
              await ref
                  .read(talkListProvider(postId, threadId).notifier)
                  .getTalk(postId, threadId);
            }
          },
        ),
      );
    }, error: (error, _) {
      return TalkFrame(
        title: title,
        actions: [
          Row(
            children: [
              postUid == uid
                  ? IconButton(
                      onPressed: () async {
                        // await model.getTalk(post!, resSort, uid);
                        // await showAccessBlockList(context, model);
                      },
                      icon: const Icon(FeatherIcons.userX))
                  : const Icon(null),
              FavoriteMark(
                  postUid: postUid,
                  postId: postId,
                  threadId: threadId,
                  title: title)
            ],
          )
        ],
        body: Center(child: Text(error.toString())),
        floatingActionButton: AddTalkFab(
          onPressed: () async {
            final result = await context.push(
                '${RouteConfig.top.path}/${RouteConfig.addTalk.path}/null/$postId/$threadId',
                extra: isUpdateToday);
            if (result != null) {
              await ref
                  .read(talkListProvider(postId, threadId).notifier)
                  .getTalk(postId, threadId);
            }
          },
        ),
      );
    }, loading: () {
      return const TalkFrame(
          actions: [],
          body: Center(child: CircularProgressIndicator()),
          title: 'Now Loading');
    });
  }
}
