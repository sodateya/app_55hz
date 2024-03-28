import 'package:app_55hz/%20presentation/admob/provider/admob_counter.dart';
import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/search/provider/search_loading_provider.dart';
import 'package:app_55hz/%20presentation/search/provider/search_page_index_provider.dart';
import 'package:app_55hz/%20presentation/search/provider/search_thread_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/is_update_today_provider.dart';
import 'package:app_55hz/%20presentation/top/widget/body/list_tile_9ch.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/component/list_componet/component_frame.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key, required this.searchWord});
  final String searchWord;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPost = ref.watch(searchThreadProvider(searchWord));
    final page = ref.watch(searchPageIndexProvider);
    final isSearchLoading = ref.watch(searchLoadingProvider);
    return searchPost.when(data: (data) {
      return ComponentFrame(
        isDisplaySort: false,
        title: '検索ワード : $searchWord',
        listView: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.read(admobCounterProvider.notifier).increment();

                  await ref.read(searchPageIndexProvider.notifier).resetPage();
                  await ref
                      .read(searchThreadProvider(searchWord).notifier)
                      .searchAlgolia(searchWord);
                },
                child: Stack(
                  children: [
                    const BackImg(),
                    ListView.builder(
                        // controller: controller..addListener(getMore),
                        itemCount: data.length + 1,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return i == data.length
                              //リストの最後にさらに表示するボタンをおく
                              ? isSearchLoading
                                  ? const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : TextButton(
                                      onPressed: () async {
                                        await ref
                                            .read(searchPageIndexProvider
                                                .notifier)
                                            .nextPage();
                                        await ref
                                            .read(
                                                searchThreadProvider(searchWord)
                                                    .notifier)
                                            .moreSearchAlgolia(page);
                                      },
                                      child: const Text(
                                        'さらに表示する',
                                        style: TextStyle(
                                            color: Color(0xff78C2C4),
                                            fontWeight: FontWeight.bold),
                                      ))
                              : ListTile9ch(
                                  isUpdateToday: ref.read(
                                      isUpdateTodayProvider(data[i].upDateAt!)),
                                  color: const Color(0xff78C2C4),
                                  posts: data[i],
                                  onLongPressed: () {},
                                  onPressed: () async {
                                    final uid = ref
                                        .read(firebaseAuthInstanceProvider)
                                        .currentUser!
                                        .uid;
                                    context.push(
                                        '${RouteConfig.top.path}/${RouteConfig.talk.path}/${data[i].uid}/${data[i].threadId}/${data[i].documentID}',
                                        extra: [
                                          data[i].title,
                                          ref.read(isUpdateTodayProvider(
                                              data[i].upDateAt!))
                                        ]);
                                    if (data[i]
                                        .read!
                                        .contains(uid.substring(20))) {
                                    } else {
                                      final notifier = ref.read(
                                          searchThreadProvider(searchWord)
                                              .notifier);
                                      notifier.readPost(data[i], i);
                                    }
                                  },
                                );
                        }),
                    Container(
                        alignment: Alignment.bottomCenter,
                        child: const BannerWidget())
                  ],
                ),
              ),
            ),
          ],
        ),
        appBarColor: const Color(0xff78C2C4),
      );
    }, error: (e, __) {
      return ComponentFrame(
        appBarColor: const Color(0xff78C2C4),
        title: '検索ワード : $searchWord',
        listView: Center(
          child: Text(e.toString()),
        ),
      );
    }, loading: () {
      return ComponentFrame(
        appBarColor: const Color(0xff78C2C4),
        title: '検索ワード : $searchWord',
        listView: const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
