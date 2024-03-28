import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pass_is_ok_provider.g.dart';

@riverpod
bool passIsOk(PassIsOkRef ref) {
  String pass = ref.watch(passIsOkLogicProvider);
  bool passIsOk = pass.length >= 8;

  return passIsOk;
}

@riverpod
class PassIsOkLogic extends _$PassIsOkLogic {
  @override
  String build() {
    String passWord = '';
    return passWord;
  }

  void change(String pass) {
    state = pass;
  }
}
