import 'package:app_55hz/%20presentation/search/widget/search_dialog.dart';
import 'package:app_55hz/%20presentation/top/provider/threads_list_provider.dart';
import 'package:app_55hz/%20presentation/top/widget/body/list_view_9ch.dart';
import 'package:app_55hz/%20presentation/top/widget/top_frame.dart';
import 'package:app_55hz/component/drawer.dart';
import 'package:app_55hz/config/sort/thread_sort_provider.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopPage extends HookConsumerWidget {
  const TopPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thread = ref.watch(threadsListProvider);
    return thread.when(
        data: (threads) {
          final tab =
              threads.map((Thread thread) => Tab(text: thread.title)).toList();
          final threadPage =
              threads.map((e) => ListView9ch(thread: e)).toList();

          return TopFrame(
              drawer: const DefaultDrawer(),
              tab: tab,
              onPressedHistory: () async {
                await ref.read(threadSortProvider.notifier).changeThreadSort();
              },
              onPressedSearch: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const SearchDialog();
                    });
              },
              body: threadPage);
        },
        error: (error, _) {
          return TopFrame(
              tab: const [Tab(text: '')],
              onPressedHistory: () {},
              onPressedSearch: () {},
              body: [Center(child: Text(error.toString()))]);
        },
        loading: () => TopFrame(
            tab: const [Tab(text: '')],
            onPressedHistory: () {},
            onPressedSearch: () {},
            body: const [Center(child: CircularProgressIndicator())]));
  }
}
