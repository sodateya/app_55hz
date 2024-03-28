import 'package:app_55hz/%20presentation/setting/provider/my_thread_id_list_provider.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChoseThreadSwitch extends ConsumerWidget {
  const ChoseThreadSwitch({super.key, required this.thread});
  final Thread thread;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myThreadList = ref.watch(myThreadIdListProvider);

    return myThreadList.when(
        data: (data) {
          return CupertinoSwitch(
            activeColor: const Color(0xff2EA9DF),
            value: data.contains(thread.documentID),
            onChanged: (value) async {
              final notifier = ref.read(myThreadIdListProvider.notifier);
              if (value) {
                notifier.addMyThread(thread);
              } else {
                notifier.removeMyThread(thread);
              }
            },
          );
        },
        error: (__, _) => const SizedBox.shrink(),
        loading: () => const CircularProgressIndicator());
  }
}
