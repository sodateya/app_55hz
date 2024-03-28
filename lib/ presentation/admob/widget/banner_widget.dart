import 'package:app_55hz/%20presentation/admob/widget/admob_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key, this.adSize = AdSize.banner});
  final AdSize? adSize;
  @override
  Widget build(BuildContext context) {
    BannerAd banner = BannerAd(
      listener: const BannerAdListener(),
      size: adSize!,
      adUnitId: AdmobHelper.bannerAdUnitId!,
      request: const AdRequest(),
    )..load();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Container(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
        alignment: Alignment.center,
        child: AdWidget(ad: banner),
      ),
    );
  }
}
