import 'package:app_55hz/config/shared_prefarence/config_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_name_provider.g.dart';

@riverpod
class MyName extends _$MyName {
  @override
  Future<String?> build() {
    final handleName = ref
        .watch(configProvider.future)
        .then((value) => value.getString('handleName'));

    return handleName;
  }

  Future changeHandleName(String handleName) async {
    final pref = await ref.watch(configProvider.future);

    pref.setString('handleName', handleName);

    state = AsyncData(handleName);
  }
}
