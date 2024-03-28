// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/cupertino.dart';

class AdmobHelper with ChangeNotifier {
  // ignore: body_might_complete_normally_nullable
  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3482694581552522/6996339951';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3482694581552522/9439601709';
    }
  }

  // ignore: body_might_complete_normally_nullable
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3482694581552522/3657134860';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3482694581552522/5888672841';
    }
  }
}
// banner ca-app-pub-3482694581552522/5888672841
// interstaitial ca-app-pub-3482694581552522/9439601709