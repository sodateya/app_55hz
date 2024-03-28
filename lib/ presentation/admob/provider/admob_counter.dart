import 'package:app_55hz/%20presentation/admob/provider/interstitial/interstitial_9ch_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admob_counter.g.dart';

@riverpod
class AdmobCounter extends _$AdmobCounter {
  @override
  int build() {
    return 0;
  }

  void increment() {
    if (state == 7) {
      ref.read(interstitial9chProvider.notifier).createAd();
      reset();
    }
    state++;
    print(state);
  }

  void reset() {
    state = 0;
    print(state);
  }
}
