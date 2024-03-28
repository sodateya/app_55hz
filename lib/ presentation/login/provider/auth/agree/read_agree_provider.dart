import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'read_agree_provider.g.dart';

@riverpod
class ReadAgree extends _$ReadAgree {
  @override
  bool build() {
    bool readAgree = false;
    return readAgree;
  }

  void changeRead(bool? isRead) {
    if (isRead == null) {
      state = !state;
    } else {
      state = isRead;
    }
  }
}
