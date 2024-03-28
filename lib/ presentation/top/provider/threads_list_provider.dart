import 'package:app_55hz/%20presentation/top/provider/ref/my_thread_ref_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/thread_ref_provider.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'threads_list_provider.g.dart';

@riverpod
class ThreadsList extends _$ThreadsList {
  @override
  Future<List<Thread>> build() async {
    final thread = await fetchThread();
    return thread;
  }

  Future fetchThread() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? isMyThreads = pref.getBool('isMyThreads');
    if (isMyThreads == null) {
      await pref.setBool('isMyThreads', false);
      isMyThreads = false;
    } else {
      isMyThreads = pref.getBool('isMyThreads');
    }
    if (isMyThreads == false) {
      final threads = await ref
          .watch(threadRefProvider)
          .orderBy('createdAt', descending: true)
          .get();

      final list = await Future.wait(threads.docs.map((e) async {
        final id = e.id;
        return e.data().copyWith(documentID: id);
      }).toList());
      return list;
    } else {
      final threads = await ref
          .watch(myThreadRefProvider)
          .orderBy('createdAt', descending: false)
          .get();
      final list = await Future.wait(threads.docs.map((e) async {
        final id = e.id;
        return e.data().copyWith(documentID: id);
      }).toList());
      return list;
    }
  }
}
