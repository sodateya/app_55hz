import 'package:app_55hz/%20presentation/admob/provider/admob_counter.dart';
import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/my_page/provider/my_post_list_provider.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/component/list_componet/component_frame.dart';
import 'package:app_55hz/component/list_componet/component_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myPost = ref.watch(myPostListProvider);

    return myPost.when(data: (data) {
      return ComponentFrame(
          appBarColor: const Color(0xffBA9132),
          title: 'マイページ',
          listView: ComponentListView(
              tileColor: const Color(0xffEFBB24),
              onRefresh: () async {
                await ref.read(myPostListProvider.notifier).getMyPost();
                ref.read(admobCounterProvider.notifier).increment();
              },
              getMoreMethod: () {
                ref.read(myPostListProvider.notifier).getMoreMyPost();
              },
              list: data.posts));
    }, error: (e, __) {
      return ComponentFrame(
        appBarColor: const Color(0xffBA9132),
        title: 'マイページ',
        listView: Stack(
          children: [
            const BackImg(),
            Center(
              child: Text(e.toString()),
            ),
            Container(
                alignment: Alignment.bottomCenter, child: const BannerWidget())
          ],
        ),
      );
    }, loading: () {
      return const ComponentFrame(
        appBarColor: Color(0xffBA9132),
        title: 'マイページ',
        listView: Center(child: CircularProgressIndicator()),
      );
    });
  }
}
