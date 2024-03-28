import 'package:app_55hz/config/shared_prefarence/config_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'res_sort_provider.g.dart';

@riverpod
class ResSort extends _$ResSort {
  @override
  Future<bool?> build() {
    final resSort = ref
        .watch(configProvider.future)
        .then((value) => value.getBool('resSort'));

    return resSort;
  }

  Future changeResSort() async {
    final pref = await ref.watch(configProvider.future);

    pref.setBool('resSort', !state.value!);

    state = AsyncData(!state.value!);
  }
}
