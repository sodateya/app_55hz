// ignore_for_file: use_build_context_synchronously

import 'package:app_55hz/domain/thread.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import '../talk/talk_page.dart';
import 'add_thread_model.dart';

const image = AssetImage('images/washi1.png');

class AddThreadPage extends StatelessWidget {
  Thread thread;
  String title;
  String uid;
  List blockUsers;
  AdInterstitial adInterstitial;
  TextEditingController titleController = TextEditingController();
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId,
    request: const AdRequest(),
  )..load();
  AddThreadPage(
      {Key key,
      this.thread,
      this.title,
      this.uid,
      this.adInterstitial,
      this.blockUsers})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: AddThreadModel(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xffFCFAF2),
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
            backgroundColor: const Color(0xff616138),
            title: Text('"$title"板にスレ追加',
                style: GoogleFonts.sawarabiMincho(
                  color: const Color(0xffFCFAF2),
                )),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<AddThreadModel>(
                  builder: (context, model, child) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                              style: GoogleFonts.sawarabiMincho(
                                color: const Color(0xff43341B),
                              ),
                              maxLength: 128,
                              controller: titleController,
                              onChanged: (text) {
                                model.title = text;
                              },
                              decoration: InputDecoration(
                                labelText: 'スレッドのタイトルを入力',
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide:
                                      const BorderSide(color: Colors.black54),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xff33A6B8), width: 3.0),
                                ),
                              )),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff0C4842), //ボタンの背景色
                                ),
                                onPressed: model.isLoading
                                    ? null
                                    : () async {
                                        FocusScope.of(context).unfocus();
                                        model.title = titleController.text;
                                        await model.startLoading();
                                        await addThread(model, context);
                                        await model.endLoading();
                                      },
                                icon: const Icon(Feather.edit_3),
                                label: Text('スレッドを投稿する',
                                    style: GoogleFonts.sawarabiMincho(
                                      color: const Color(0xffFCFAF2),
                                    )),
                              ),
                              const SizedBox(width: 20)
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: SizedBox(
            height: 64,
            child: AdWidget(
              ad: banner,
            ),
          ),
        ),
      ),
    );
  }

  Future addThread(AddThreadModel model, BuildContext context) async {
    final bool resSort = await model.getResSort();
    try {
      await model.addThreadToFirebase(thread, uid, blockUsers);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('投稿完了しました'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TalkPage(
                          uid: uid,
                          adInterstitial: adInterstitial,
                          post: model.post,
                          resSort: resSort),
                    ),
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      final snackBar = SnackBar(
        backgroundColor: const Color(0xffD0104C),
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class MyImageWidget extends StatelessWidget {
  const MyImageWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: const AssetImage('images/washi1.png'),
      fit: BoxFit.cover,
      color: const Color(0xff616138),
      colorBlendMode: BlendMode.modulate,
    );
  }
}
