import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_agree_provider.g.dart';

@riverpod
class IsAgree extends _$IsAgree {
  @override
  bool build() {
    bool isAgree = false;
    return isAgree;
  }

  void changeAgree(bool? isAgree) {
    if (isAgree == null) {
      state = !state;
    } else {
      state = isAgree;
    }
  }
}
