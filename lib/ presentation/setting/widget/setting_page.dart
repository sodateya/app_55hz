import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/setting/widget/my_thread_list_view.dart';
import 'package:app_55hz/%20presentation/setting/widget/switch/res_sort_switch.dart';
import 'package:app_55hz/%20presentation/setting/widget/switch/thread_sort.switch.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/washi1.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xff616138),
                  BlendMode.modulate,
                ),
              ),
            ),
          ),
          title: const Text('設定',
              style: TextStyle(
                  color: Color(0xffFCFAF2),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
          backgroundColor: const Color(0xff616138),
        ),
        body: Stack(
          children: [
            const BackImg(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('アプリ起動時のスレッド表示を更新順にする'),
                      ThreadSortSwitch()
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('コメントの表示を１からにする'), ResSortSwitch()],
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      '〜板設定〜',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff43341B),
                          fontSize: 15.0),
                    ),
                  ),
                  Expanded(child: MyThreadListView()),
                ],
              ),
            ),
            Container(
                alignment: Alignment.bottomCenter, child: const BannerWidget())
          ],
        ));
  }
}
