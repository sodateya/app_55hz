import 'package:app_55hz/%20presentation/top/provider/ref/thread_ref_provider.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_thread_list_provider.g.dart';

@riverpod
class SettingThreadList extends _$SettingThreadList {
  @override
  Future<List<Thread>> build() async {
    final thread = await fetchThread();
    return thread;
  }

  Future fetchThread() async {
    final threads = await ref
        .watch(threadRefProvider)
        .orderBy('createdAt', descending: true)
        .get();
    final list = await Future.wait(threads.docs.map((e) async {
      final id = e.id;
      return e.data().copyWith(documentID: id);
    }).toList());
    return list;
  }
}
