// ignore_for_file: must_be_immutable, missing_return

import 'package:app_55hz/version1/main/admob.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'block_list_model.dart';

class BlockListPage extends StatelessWidget {
  String uid;
  BlockListPage({super.key, required this.uid});
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
        value: BlockListModel()..fetchBlockList(uid),
        child: Scaffold(
            backgroundColor: const Color(0xffFCFAF2),
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/washi1.png'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Color(0xff1C1C1C),
                      BlendMode.modulate,
                    ),
                  ),
                ),
              ),
              title: const Text('ブロックリスト',
                  style: TextStyle(
                      color: Color(0xffFCFAF2),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              backgroundColor: const Color(0xff1C1C1C),
            ),
            body: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      const Color(0xffFCFAF2).withOpacity(0.4),
                      BlendMode.dstATop,
                    ),
                    image: const AssetImage('images/washi1.png'),
                    fit: BoxFit.fill,
                  )),
                ),
                SizedBox(
                  width: size.width,
                  child: Consumer<BlockListModel>(
                      builder: (context, model, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await model.fetchBlockList(uid);
                            },
                            child: model.blockList.isEmpty
                                ? const Center(
                                    child: Text('現在ブロックしているユーザーはいません',
                                        style: TextStyle(
                                            color: Color(0xff43341B),
                                            fontWeight: FontWeight.bold)),
                                  )
                                : SizedBox(
                                    height: size.height * 0.8,
                                    width: size.width * 0.97,
                                    child: ListView.builder(
                                        itemCount: model.blockList.length,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Card(
                                            elevation: 9,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: const DecorationImage(
                                                    image: AssetImage(
                                                        'images/washi1.png'),
                                                    fit: BoxFit.fill,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Color(0xff434343),
                                                            BlendMode
                                                                .modulate)),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                    model.blockList[index]
                                                        .toString()
                                                        .substring(20),
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xffFCFAF2),
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                onTap: () async {
                                                  await unBlockDialog(
                                                      context,
                                                      uid,
                                                      model.blockList[index],
                                                      model);
                                                },
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
            bottomNavigationBar: SizedBox(
                height: 64,
                child: AdWidget(
                  ad: banner,
                ))));
  }

  Future unBlockDialog(BuildContext context, String uid, String blockUser,
      BlockListModel model) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('${blockUser.substring(20)}をブロック解除しますか？',
              style: const TextStyle(color: Color(0xffFCFAF2))),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: const Text('いいえ'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('解除する'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await model.removeToBlockList(uid, blockUser);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
