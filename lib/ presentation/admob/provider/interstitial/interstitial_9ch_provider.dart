import 'dart:async';

import 'package:app_55hz/%20presentation/admob/widget/admob_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interstitial_9ch_provider.g.dart';

@riverpod
class Interstitial9ch extends _$Interstitial9ch {
  @override
  InterstitialAd? build() {
    InterstitialAd? interstitialAd;

    return interstitialAd;
  }

  void createAd() async {
    // Completerを使用して広告がロードされたときに通知します。
    Completer completer = Completer();

    await InterstitialAd.load(
      adUnitId: AdmobHelper.interstitialAdUnitId!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          print('### add loaded');

          completer.complete(); // 広告がロードされたので通知
          showAd(ad);
        },
        onAdFailedToLoad: (LoadAdError error) {
          createAd();

          completer.complete(); // 広告のロードに失敗したので通知
        },
      ),
    );

    print(state);
    return completer.future; // 広告がロードされるまで待機します。
  }

  Future<void> showAd(InterstitialAd ad) async {
    print(state);
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("ad onAdshowedFullscreen");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print("ad Disposed");
        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        print('$ad OnAdFailed $aderror');
        ad.dispose();
        createAd();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );

    await ad.show();
    state = null;
  }
}
