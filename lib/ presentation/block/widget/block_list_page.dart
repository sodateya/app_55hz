import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/block/provider/block_users_provider.dart';
import 'package:app_55hz/%20presentation/block/widget/block_dialog.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlockListPage extends ConsumerWidget {
  const BlockListPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final blockList = ref.watch(blockUsersProvider);
    final Widget listView = blockList.when(
        data: (data) {
          return Column(
            children: [
              Expanded(
                child: data!.isEmpty
                    ? const Center(child: Text('現在ブロックしているユーザはいません'))
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Card(
                            elevation: 9,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image: AssetImage('images/washi1.png'),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Color(0xff434343), BlendMode.modulate)),
                              ),
                              child: ListTile(
                                title: Text(
                                  data[i].toString().substring(20),
                                  style:
                                      const TextStyle(color: Color(0xffFCFAF2)),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return BlockDialog(
                                          partnerUid: data[i],
                                          isRemove: true,
                                        );
                                      });
                                },
                              ),
                            ),
                          );
                        }),
              ),
            ],
          );
        },
        error: (e, __) => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ブロックリスト',
          style: TextStyle(color: Color(0xffFCFAF2)),
        ),
        flexibleSpace: const AppBarBackImg(
          color: Color(0xff1C1C1C),
        ),
      ),
      body: Stack(
        children: [
          const BackImg(),
          listView,
          Container(
              alignment: Alignment.bottomCenter,
              child: const BannerWidget(
                adSize: AdSize.fullBanner,
              ))
        ],
      ),
    );
  }
}
