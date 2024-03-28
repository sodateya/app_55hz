import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_page_index_provider.g.dart';

@riverpod
class SearchPageIndex extends _$SearchPageIndex {
  @override
  int build() {
    return 1;
  }

  Future<void> resetPage() async {
    state = 1;
  }

  Future<void> nextPage() async {
    state = state + 1;
  }
}
