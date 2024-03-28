import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/top/widget/appBar/app_bar_9ch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TopFrame extends ConsumerWidget {
  const TopFrame({
    super.key,
    required this.tab,
    this.drawer,
    required this.onPressedHistory,
    required this.onPressedSearch,
    required this.body,
  });
  final List<Tab> tab;
  final Widget? drawer;
  final void Function()? onPressedHistory;
  final void Function()? onPressedSearch;
  final List<Widget> body;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: tab.length,
      child: Stack(
        children: [
          Scaffold(
            drawer: drawer,
            backgroundColor: const Color(0xffFCFAF2),
            appBar: AppBar9ch(
                drawer: drawer,
                tab: tab,
                onPressedHistory: onPressedHistory,
                onPressedSearch: onPressedSearch),
            body: TabBarView(children: body),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: const BannerWidget(),
          ),
        ],
      ),
    );
  }
}
