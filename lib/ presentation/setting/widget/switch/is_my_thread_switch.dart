import 'package:app_55hz/config/is_my_thread/is_my_thread_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IsMyThreadSwitch extends ConsumerWidget {
  const IsMyThreadSwitch({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMyThread = ref.watch(isMyThreadProvider);
    return isMyThread.when(
        data: (value) {
          return CupertinoSwitch(
            activeColor: const Color(0xff2EA9DF),
            value: !isMyThread.value!,
            onChanged: (value) {
              ref.read(isMyThreadProvider.notifier).changeIsMyThreads();
            },
          );
        },
        error: (error, e) => const SizedBox.shrink(),
        loading: () => const CircularProgressIndicator());
  }
}
