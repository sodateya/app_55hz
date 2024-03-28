import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/favorite/provider/favorite_page_provider/favorite_post_list_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/is_update_today_provider.dart';
import 'package:app_55hz/%20presentation/top/widget/body/list_tile_9ch.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/component/get_more_button.dart';
import 'package:app_55hz/component/list_componet/component_frame.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoritePage extends HookConsumerWidget {
  const FavoritePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();

    final favoriteList = ref.watch(favoritePostListProvider);
    return favoriteList.when(
      data: (list) {
        final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;

        return ComponentFrame(
          isDisplaySort: false,
          title: 'お気に入り',
          listView: Stack(
            children: [
              const BackImg(),
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: list.posts.length + 1,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return i == list.posts.length
                              ? GetMoreButton(
                                  onPressed: () async {
                                    ref
                                        .read(favoritePostListProvider.notifier)
                                        .getMorePost();
                                  },
                                )
                              : ListTile9ch(
                                  isUpdateToday: ref.read(isUpdateTodayProvider(
                                      list.posts[i].upDateAt!)),
                                  color: const Color(0xffDC9FB4),
                                  posts: list.posts[i],
                                  onLongPressed: () {},
                                  onPressed: () async {
                                    context.push(
                                        '${RouteConfig.top.path}/${RouteConfig.talk.path}/${list.posts[i].uid}/${list.posts[i].threadId}/${list.posts[i].documentID}',
                                        extra: [
                                          list.posts[i].title,
                                          ref.read(isUpdateTodayProvider(
                                              list.posts[i].upDateAt!))
                                        ]);
                                    if (list.posts[i].read!
                                        .contains(uid.substring(20))) {
                                    } else {
                                      final notifier = ref.read(
                                          favoritePostListProvider.notifier);
                                      notifier.readPost(list.posts[i], i);
                                    }
                                  },
                                );
                        }),
                  ),
                ],
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: const BannerWidget())
            ],
          ),
          appBarColor: const Color(0xffDC9FB4),
        );
      },
      error: (error, _) => ComponentFrame(
        isDisplaySort: false,
        title: 'お気に入り',
        listView: Stack(
          children: [
            const BackImg(),
            const Center(child: Text('お気に入りされている投稿がありません')),
            Container(
                alignment: Alignment.bottomCenter, child: const BannerWidget())
          ],
        ),
        appBarColor: const Color(0xffDC9FB4),
      ),
      loading: () => const ComponentFrame(
          isDisplaySort: false,
          title: 'お気に入り',
          listView: Center(child: CircularProgressIndicator()),
          appBarColor: Color(0xffDC9FB4)),
    );
  }
}
