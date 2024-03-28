import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/config/sort/thread_sort_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ComponentFrame extends ConsumerWidget {
  const ComponentFrame(
      {super.key,
      required this.title,
      required this.listView,
      required this.appBarColor,
      this.isDisplaySort = true});
  final String title;
  final Widget listView;
  final Color appBarColor;
  final bool isDisplaySort;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(threadSortProvider).value;
    final sortTitle = sort == 'createdAt' ? '投稿順' : '更新順';

    return Scaffold(
        backgroundColor: const Color(0xffFCFAF2),
        appBar: AppBar(
          actions: [
            isDisplaySort
                ? IconButton(
                    onPressed: () async {
                      await ref
                          .read(threadSortProvider.notifier)
                          .changeThreadSort();
                    },
                    icon: const Icon(Icons.history))
                : const SizedBox.shrink(),
          ],
          flexibleSpace: AppBarBackImg(
            color: appBarColor,
          ),
          title: Column(
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Color(0xffFCFAF2), fontSize: 25.0)),
              isDisplaySort
                  ? Container(
                      width: 160,
                      color: const Color(0xffFCFAF2),
                      alignment: Alignment.center,
                      child: Text(sortTitle,
                          style: const TextStyle(
                              color: Color(0xff616138),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)))
                  : const SizedBox.shrink()
            ],
          ),
          centerTitle: true,
        ),
        body: listView);
  }
}
