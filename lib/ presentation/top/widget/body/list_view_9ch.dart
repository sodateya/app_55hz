import 'package:app_55hz/%20presentation/admob/provider/admob_counter.dart';
import 'package:app_55hz/%20presentation/block/provider/block_users_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/search/provider/search_loading_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/bad_post_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/is_update_today_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/post_list_provider.dart';
import 'package:app_55hz/%20presentation/top/widget/FAB/fab_9ch.dart';
import 'package:app_55hz/%20presentation/top/widget/body/list_tile_9ch.dart';
import 'package:app_55hz/component/dialog_9ch.dart';
import 'package:app_55hz/component/get_more_button.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListView9ch extends HookConsumerWidget {
  const ListView9ch({super.key, required this.thread});
  final Thread thread;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final uid = ref.watch(firebaseAuthInstanceProvider).currentUser!.uid;
    final posts = ref.watch(postListProviderProvider(thread));
    final isSearchLoading = ref.watch(searchLoadingProvider);

    return Scaffold(
      body: posts.when(
          data: (data) {
            /// ブロックリストに入っているものを削除
            List<Post> posts = [];
            posts.addAll(data.posts);

            //アクブロされているものをリストから取り除く
            posts.removeWhere((post) => post.accessBlock!.contains(uid));

            //ブロックされているものをリストから取り除く
            ref.watch(blockUsersProvider).when(
                data: (data) {
                  posts.retainWhere((element) => !data!.contains(element.uid));
                },
                error: (e, __) {},
                loading: () {});

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      ref.read(admobCounterProvider.notifier).increment();

                      await ref
                          .read(postListProviderProvider(thread).notifier)
                          .getPostSelect(thread);
                    },
                    child: SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                          itemCount: posts.length + 1,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return i == posts.length
                                //リストの最後にさらに表示するボタンをおく
                                ? GetMoreButton(
                                    onPressed: () async {
                                      ref
                                          .read(postListProviderProvider(thread)
                                              .notifier)
                                          .getMoreSelect(thread);
                                    },
                                  )
                                : Column(
                                    children: [
                                      ListTile9ch(
                                        posts: posts[i],
                                        isUpdateToday: ref.read(
                                            IsUpdateTodayProvider(
                                                posts[i].upDateAt!)),
                                        onPressed: () async {
                                          context.push(
                                              '${RouteConfig.top.path}/${RouteConfig.talk.path}/${posts[i].uid}/${posts[i].threadId}/${posts[i].documentID}',
                                              extra: [
                                                posts[i].title,
                                                ref.read(IsUpdateTodayProvider(
                                                    posts[i].upDateAt!))
                                              ]);
                                          if (posts[i]
                                              .read!
                                              .contains(uid.substring(20))) {
                                          } else {
                                            ref
                                                .read(postListProviderProvider(
                                                        thread)
                                                    .notifier)
                                                .readPost(posts[i], i);
                                          }
                                        },
                                        onLongPressed: () {
                                          final uid = ref
                                              .read(
                                                  firebaseAuthInstanceProvider)
                                              .currentUser!
                                              .uid;

                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                if (posts[i].uid == uid) {
                                                  return Dialog9ch(
                                                      title: 'この投稿を削除しますか？',
                                                      buttonLabel: '削除',
                                                      onPressed: () {
                                                        final notifier = ref.read(
                                                            postListProviderProvider(
                                                                    thread)
                                                                .notifier);
                                                        notifier.deleteMyThread(
                                                            posts[i].threadId!,
                                                            posts[i]
                                                                .documentID!);
                                                        Navigator.pop(context);
                                                      });
                                                } else {
                                                  return Dialog9ch(
                                                      title: 'この投稿を違反報告しますか？',
                                                      buttonLabel: '報告する',
                                                      onPressed: () {
                                                        final notifier =
                                                            ref.read(
                                                                badPostProvider
                                                                    .notifier);
                                                        notifier.addBadPost(
                                                            posts[i].threadId!,
                                                            posts[i]
                                                                .documentID!,
                                                            posts[i].uid!);
                                                        Navigator.pop(context);
                                                      });
                                                }
                                              });
                                        },
                                      ),
                                    ],
                                  );
                          }),
                    ),
                  ),
                ),
              ],
            );
          },
          error: ((error, stackTrace) => Center(
                child: Text(error.toString()),
              )),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
      floatingActionButton: Fab9ch(thread: thread),
    );
  }
}
