import 'package:app_55hz/config/sort/thread_sort_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThreadSortSwitch extends ConsumerWidget {
  const ThreadSortSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resSort = ref.watch(threadSortProvider);
    return resSort.when(
        data: (value) {
          return CupertinoSwitch(
            activeColor: const Color(0xff2EA9DF),
            value: resSort.value == 'upDateAt',
            onChanged: (value) {
              ref.read(threadSortProvider.notifier).changeThreadSort();
            },
          );
        },
        error: (error, e) => const SizedBox.shrink(),
        loading: () => const CircularProgressIndicator());
  }
}
