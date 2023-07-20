// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, must_be_immutable

import 'package:app_55hz/main/admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'edit_thread_model.dart';

class EditThreadPage extends StatefulWidget {
  EditThreadPage({super.key, required this.uid});
  AdInterstitial? adInterstitial;
  String uid;
  bool isChanged = false;
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();

  @override
  _EditThreadState createState() => _EditThreadState();
}

class _EditThreadState extends State<EditThreadPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Size size =
        MediaQuery.of(context).size; // AutomaticKeepAliveClientMixin
    return ChangeNotifierProvider.value(
      value: EditThreadModel()
        ..fetchThread()
        ..fetchMyThreads(widget.uid)
        ..getConfig(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Consumer<EditThreadModel>(builder: (context, model, child) {
            return AppBar(
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
              leading: IconButton(
                icon: const Icon(
                  FeatherIcons.chevronLeft,
                  color: Color(0xffFCFAF2),
                ),
                onPressed: () async {
                  Navigator.of(context).pop(widget.isChanged);
                },
              ),
              title: const Text(
                '設定',
                style: TextStyle(
                    color: Color(0xffFCFAF2),
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color(0xff616138),
            );
          }),
        ),
        backgroundColor: const Color(0xffFCFAF2),
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
              height: size.height * 0.86,
              child:
                  Consumer<EditThreadModel>(builder: (context, model, child) {
                final threads = model.threads;
                final myThreads = model.myThreads;
                return Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('アプリ起動時のスレッド表示を更新順にする',
                                      style:
                                          TextStyle(color: Color(0xff43341B))),
                                  IconButton(
                                      onPressed: () async {
                                        if (model.threadSort == false) {
                                          await model.setTrueTheradSort();
                                          widget.isChanged = true;
                                        } else {
                                          await model.setFalseTheradSort();
                                          widget.isChanged = true;
                                        }
                                      },
                                      icon: model.threadSort == false
                                          ? const Icon(
                                              FeatherIcons.toggleLeft,
                                              color: Colors.grey,
                                            )
                                          : const Icon(
                                              FeatherIcons.toggleRight,
                                              color: Color(0xff2EA9DF),
                                            )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('コメントの表示を１からにする',
                                      style:
                                          TextStyle(color: Color(0xff43341B))),
                                  IconButton(
                                      onPressed: () async {
                                        if (model.resSort == false) {
                                          await model.setTrueResSort();
                                          widget.isChanged = true;
                                        } else {
                                          await model.setFalseResSort();
                                          widget.isChanged = true;
                                        }
                                      },
                                      icon: model.resSort != false
                                          ? const Icon(
                                              FeatherIcons.toggleLeft,
                                              color: Colors.grey,
                                            )
                                          : const Icon(
                                              FeatherIcons.toggleRight,
                                              color: Color(0xff2EA9DF),
                                            ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: size.width,
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  '〜板設定〜',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff43341B),
                                      fontSize: 15.0),
                                ),
                              ),
                            ),
                            Container(
                              height: size.height * 0.608,
                              child: ListView.builder(
                                itemCount: threads.length + 1,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return index == 0
                                      ? ListTile(
                                          title: const Padding(
                                            padding: EdgeInsets.only(
                                                top: 17, bottom: 10),
                                            child: Text(
                                              '全表示',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xff43341B),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          trailing: model.isMyThreads == false
                                              ? const Icon(
                                                  FeatherIcons.toggleRight,
                                                  color: Color(0xff2EA9DF),
                                                )
                                              : const Icon(
                                                  FeatherIcons.toggleLeft),
                                          onTap: () async {
                                            widget.isChanged = true;
                                            if (model.isMyThreads == false) {
                                              await model.setTrueisMyThreads();
                                              model.isMyThreads =
                                                  model.isMyThreads;
                                            } else {
                                              await model.setFalseIsMyThreads();
                                              model.isMyThreads =
                                                  model.isMyThreads;
                                            }
                                          },
                                        )
                                      : ListTile(
                                          title: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 17, bottom: 10),
                                            child: Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${threads[index - 1].title}板',
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.clip,
                                                      style: GoogleFonts
                                                          .sawarabiMincho(
                                                        textStyle:
                                                            Theme.of(context)
                                                                .textTheme
                                                                .headline4,
                                                        color: const Color(
                                                            0xff43341B),
                                                        fontSize: 15.0,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          trailing: model.isMyThreads == true
                                              ? myThreads.contains(
                                                      threads[index - 1]
                                                          .documentID)
                                                  ? const Icon(
                                                      FeatherIcons.toggleRight,
                                                      color: Color(0xff2EA9DF),
                                                    )
                                                  : const Icon(
                                                      FeatherIcons.toggleLeft)
                                              : const Icon(
                                                  FeatherIcons.toggleRight,
                                                  color: Color(0xff2EA9DF),
                                                ),
                                          onTap: () async {
                                            widget.isChanged = true;
                                            if (model.isMyThreads == true) {
                                              myThreads.contains(
                                                      threads[index - 1]
                                                          .documentID)
                                                  ? await model.removeMyThreads(
                                                      widget.uid,
                                                      threads[index - 1]
                                                          .documentID!,
                                                    )
                                                  : await model.addMyThreads(
                                                      widget.uid,
                                                      threads[index - 1]
                                                          .documentID!,
                                                      threads[index - 1].title!,
                                                      DateTime.now());
                                            }
                                          },
                                        );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
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
            ad: widget.banner,
          ),
        ),
      ),
    );
  }
}
