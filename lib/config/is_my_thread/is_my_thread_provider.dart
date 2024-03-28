import 'package:app_55hz/config/shared_prefarence/config_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_my_thread_provider.g.dart';

@riverpod
class IsMyThread extends _$IsMyThread {
  @override
  Future<bool?> build() {
    final isMyThreads = ref
        .watch(configProvider.future)
        .then((value) => value.getBool('isMyThreads'));

    return isMyThreads;
  }

  Future changeIsMyThreads() async {
    final pref = await ref.watch(configProvider.future);

    pref.setBool('isMyThreads', !state.value!);

    state = AsyncData(!state.value!);
  }
}
