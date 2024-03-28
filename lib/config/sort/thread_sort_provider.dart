import 'package:app_55hz/config/shared_prefarence/config_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_sort_provider.g.dart';

@riverpod
class ThreadSort extends _$ThreadSort {
  @override
  Future<String?> build() {
    final threadSort = ref
        .watch(configProvider.future)
        .then((value) => value.getString('threadSort'));

    return threadSort;
  }

  Future changeThreadSort() async {
    final pref = await ref.watch(configProvider.future);
    if (state.value == 'createdAt') {
      pref.setString('threadSort', 'upDateAt');
      state = const AsyncData('upDateAt');
    } else {
      pref.setString('threadSort', 'createdAt');
      state = const AsyncData('createdAt');
    }
    print(state.value);
  }
}
