import 'package:app_55hz/%20presentation/top/provider/ref/my_thread_ref_provider.dart';
import 'package:app_55hz/config/is_my_thread/is_my_thread_provider.dart';
import 'package:app_55hz/config/my_threads/my_thread_list_provider.dart';
import 'package:app_55hz/config/my_threads/setting_thread_list_provider.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_thread_id_list_provider.g.dart';

@riverpod
class MyThreadIdList extends _$MyThreadIdList {
  @override
  Future<List> build() async {
    final isMyThread = await ref.watch(isMyThreadProvider.future);
    if (!isMyThread!) {
      final list = await ref.read(settingThreadListProvider.future);
      final idList = list.map((e) => e.documentID).toList();
      return idList;
    } else {
      final list = await ref.read(myThreadListProvider.future);
      final idList = list.map((e) => e!.documentID).toList();
      return idList;
    }
  }

  void addMyThread(Thread thread) {
    List list = [];
    list.addAll(state.value!);
    ref.read(myThreadRefProvider).doc(thread.documentID).set(thread);
    list.add(thread.documentID);
    state = AsyncData(list);
  }

  void removeMyThread(Thread thread) {
    List list = [];
    list.addAll(state.value!);
    ref.read(myThreadRefProvider).doc(thread.documentID).delete();
    list.remove(thread.documentID);
    state = AsyncData(list);
  }
}
