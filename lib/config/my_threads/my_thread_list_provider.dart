import 'package:app_55hz/%20presentation/top/provider/ref/my_thread_ref_provider.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_thread_list_provider.g.dart';

@riverpod
class MyThreadList extends _$MyThreadList {
  @override
  Stream<List<Thread?>> build() {
    return ref
        .watch(myThreadRefProvider)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((event) => event.docs.map((e) {
              final id = e.id;
              return e.data().copyWith(documentID: id);
            }).toList());
  }
}
