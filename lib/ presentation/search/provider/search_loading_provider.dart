import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_loading_provider.g.dart';

@riverpod
class SearchLoading extends _$SearchLoading {
  @override
  bool build() {
    return false;
  }

  void startLoading() {
    state = true;
  }

  void endLoading() {
    state = false;
  }
}
