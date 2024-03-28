import 'package:app_55hz/%20presentation/setting/provider/my_thread_id_list_provider.dart';
import 'package:app_55hz/%20presentation/setting/widget/switch/chose_thread_switch.dart';
import 'package:app_55hz/%20presentation/setting/widget/switch/is_my_thread_switch.dart';
import 'package:app_55hz/config/my_threads/setting_thread_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyThreadListView extends HookConsumerWidget {
  const MyThreadListView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threads = ref.watch(settingThreadListProvider);
    useAutomaticKeepAlive();
    return threads.when(
        data: (data) {
          return ListView.builder(
              itemCount: data.length + 2,
              itemBuilder: (context, i) {
                return i == data.length + 1
                    ? const SizedBox(
                        height: 32,
                      )
                    : i == 0
                        ? const ListTile(
                            trailing: IsMyThreadSwitch(),
                            title: Text(
                              '全表示',
                              style: TextStyle(
                                color: Color(0xff43341B),
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                              ),
                            ))
                        : ListTile(
                            onTap: () {
                              ref
                                  .read(myThreadIdListProvider.notifier)
                                  .addMyThread(data[i - 1]);
                            },
                            trailing: ChoseThreadSwitch(thread: data[i - 1]),
                            title: Text(
                              '${data[i - 1].title}板',
                              style: const TextStyle(
                                color: Color(0xff43341B),
                                fontSize: 15.0,
                                overflow: TextOverflow.clip,
                              ),
                            ));
              });
        },
        error: (__, _) => Text(__.toString()),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
