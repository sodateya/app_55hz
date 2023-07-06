// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdInterstitial with ChangeNotifier {
  int missload = 0;
  bool ready = false;
  int _counter = 0;

  int get counter => _counter;

  set counter(int value) {
    _counter = value;
    print(_counter);
    notifyListeners();

    if (_counter % 7 == 0) {
      showAd();
    }
    if (!ready) {
      createAd();
    }
  }

  InterstitialAd _interstitialAd;
  InterstitialAd get interstitialAd => _interstitialAd;
  set banner(InterstitialAd value) {
    _interstitialAd = value;
    notifyListeners();
  }

  RewardedAd _rewardedAd;
  RewardedAd get rewardedAd => _rewardedAd;
  set bannera(RewardedAd value) {
    _rewardedAd = value;
    notifyListeners();
  }

  void createAd() async {
    print("### 広告を作成します");
    if (!ready) {
      await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('### add loaded');
            _interstitialAd = ad;
            missload = 0;
            ready = true;
          },
          onAdFailedToLoad: (LoadAdError error) {
            missload++;
            _interstitialAd = null;
            if (missload <= 2) {
              createAd();
            }
          },
        ),
      );
    }
  }

  Future<void> showAd() async {
    ready = false;
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
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

    await _interstitialAd.show();
    _interstitialAd = null;
  }

  Future<void> createAdforSerch() async {
    print("### 広告を作成します");
    if (!ready) {
      // Completerを使用して広告がロードされたときに通知します。
      Completer completer = Completer();

      await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('### add loaded');
            _interstitialAd = ad;
            missload = 0;
            ready = true;
            completer.complete(); // 広告がロードされたので通知
          },
          onAdFailedToLoad: (LoadAdError error) {
            missload++;
            _interstitialAd = null;
            if (missload <= 2) {
              createAd();
            } else {
              completer.complete(); // 広告のロードに失敗したので通知
            }
          },
        ),
      );

      return completer.future; // 広告がロードされるまで待機します。
    }
  }

  Future<void> showAdforSerch(Future future) async {
    ready = false;
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print("ad onAdshowedFullscreen");
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print("ad Disposed");
        ad.dispose();

        future;
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError aderror) {
        print('$ad OnAdFailed $aderror');
        ad.dispose();
        createAd();
      },
      onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    );

    await _interstitialAd.show();
    _interstitialAd = null;
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3482694581552522/6996339951';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3482694581552522/9439601709';
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3482694581552522/3657134860';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3482694581552522/5888672841';
    }
  }
}
// banner ca-app-pub-3482694581552522/5888672841
// interstaitial ca-app-pub-3482694581552522/9439601709