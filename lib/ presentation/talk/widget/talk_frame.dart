import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TalkFrame extends ConsumerWidget {
  const TalkFrame(
      {super.key,
      required this.actions,
      required this.body,
      this.title = '',
      this.floatingActionButton});
  final List<Widget> actions;
  final Widget body;
  final String? title;
  final Widget? floatingActionButton;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarBackImg(),
        actions: actions,
        title: Text(title!,
            style: const TextStyle(color: Color(0xffFCFAF2), fontSize: 16)),
      ),
      body: Stack(
        children: [
          const BackImg(),
          body,
          Container(
              alignment: Alignment.bottomCenter, child: const BannerWidget())
        ],
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
