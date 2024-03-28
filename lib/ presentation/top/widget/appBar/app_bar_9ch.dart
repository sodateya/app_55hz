import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/config/sort/thread_sort_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppBar9ch extends ConsumerWidget implements PreferredSizeWidget {
  const AppBar9ch({
    super.key,
    required this.tab,
    this.drawer,
    required this.onPressedHistory,
    required this.onPressedSearch,
  });
  final List<Tab> tab;
  final Widget? drawer;
  final void Function()? onPressedHistory;
  final void Function()? onPressedSearch;

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(threadSortProvider);

    final sortText = sort.when(
        data: (data) => data == 'createdAt' ? '投稿順' : '更新順',
        error: (e, _) => 'Now　Loading',
        loading: () => 'Now　Loading');

    return AppBar(
        flexibleSpace: const AppBarBackImg(),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(FeatherIcons.user),
            onPressed: () async {
              if (drawer != null) {
                Scaffold.of(context).openDrawer();
              }
            },
          );
        }),
        actions: [
          IconButton(
              onPressed: onPressedHistory, icon: const Icon(Icons.history)),
          IconButton(
              onPressed: onPressedSearch,
              icon: const Icon(FeatherIcons.search)),
        ],
        title: Column(
          children: [
            const Text(
              '9ちゃんねる',
              style: TextStyle(color: Color(0xffFCFAF2), fontSize: 25.0),
            ),
            Container(
                color: const Color(0xffFCFAF2),
                alignment: Alignment.center,
                child: Text(sortText,
                    style: const TextStyle(
                        color: Color(0xff616138),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold)))
          ],
        ),
        backgroundColor: const Color(0xff616138),
        centerTitle: true,
        bottom: TabBar(
            tabs: tab,
            isScrollable: true,
            unselectedLabelColor: const Color(0xff43341B),
            labelStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color(0xffFCFAF2))));
  }
}
