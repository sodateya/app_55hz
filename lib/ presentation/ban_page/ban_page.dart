import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/component/logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BanPage extends ConsumerWidget {
  const BanPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Stack(
        children: [
          BackImg(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoImage(),
              SizedBox(height: 16),
              Center(
                child: Text('あなたはこのサービスを利用できません'),
              ),
              SizedBox(height: 80),
              BannerWidget(adSize: AdSize.largeBanner)
            ],
          ),
        ],
      ),
    );
  }
}
