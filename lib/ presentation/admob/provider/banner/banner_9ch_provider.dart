import 'package:app_55hz/%20presentation/admob/widget/admob_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'banner_9ch_provider.g.dart';

@riverpod
class Banner9ch extends _$Banner9ch {
  @override
  Future<BannerAd> build() async {
    BannerAd banner = BannerAd(
      listener: const BannerAdListener(),
      size: AdSize.banner,
      adUnitId: AdmobHelper.bannerAdUnitId!,
      request: const AdRequest(),
    )..load();

    return banner;
  }
}
