import 'package:app_55hz/config/sort/res_sort_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResSortSwitch extends ConsumerWidget {
  const ResSortSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resSort = ref.watch(resSortProvider);
    return resSort.when(
        data: (value) {
          return CupertinoSwitch(
            activeColor: const Color(0xff2EA9DF),
            value: !resSort.value!,
            onChanged: (value) {
              ref.read(resSortProvider.notifier).changeResSort();
            },
          );
        },
        error: (error, e) => const SizedBox.shrink(),
        loading: () => const CircularProgressIndicator());
  }
}
