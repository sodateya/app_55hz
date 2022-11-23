// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:app_55hz/domain/post.dart';
import 'package:app_55hz/domain/thread.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/talk_add/talk_add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AddTalkPage extends StatelessWidget {
  Thread thread;
  Post post;
  int count;
  String popID;
  String threadID;
  String uid;
  String resNumber;
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  File imageFile;
  DateTime upDateAt;
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId,
    request: const AdRequest(),
  )..load();

  AddTalkPage(
      {Key key,
      this.thread,
      this.post,
      this.count,
      this.popID,
      this.threadID,
      this.uid,
      this.resNumber,
      this.upDateAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (commentController.text == '' && resNumber != null) {
      commentController.text = '>>$resNumber';
    }
    final Size size = MediaQuery.of(context).size;
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return ChangeNotifierProvider.value(
      value: AddTalkModel()..getName(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xffFCFAF2),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            flexibleSpace: const Image(
              image: AssetImage('images/washi1.png'),
              fit: BoxFit.cover,
              color: Color(0xff616138),
              colorBlendMode: BlendMode.modulate,
            ),
            backgroundColor: const Color(0xff616138),
            title: Text(
              'レスポンス',
              style: GoogleFonts.sawarabiMincho(
                  color: const Color(0xffFCFAF2),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
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
              Center(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: bottomSpace),
                    child: Consumer<AddTalkModel>(
                      builder: (context, model, child) {
                        if (post != null) {
                          model.getMainToken(threadID, popID);
                          print(model.mainToken);
                        }
                        nameController.text == ''
                            ? nameController.text = model.name
                            : nameController.text = nameController.text;
                        return Stack(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                child,
                                Container(
                                  child: imageFile == null
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: size.width * 0.75,
                                              child: TextFormField(
                                                  style: GoogleFonts
                                                      .sawarabiMincho(
                                                    color:
                                                        const Color(0xff43341B),
                                                  ),
                                                  maxLength: 2048,
                                                  controller: imageController,
                                                  decoration: InputDecoration(
                                                    labelText: '画像URL',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Colors
                                                                  .black54),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              25.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color(
                                                                  0xff33A6B8),
                                                              width: 3.0),
                                                    ),
                                                  )),
                                            ),
                                            IconButton(
                                                onPressed: () async {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  await model.pickImage();
                                                  imageFile = model.imageFile;
                                                  imageController.clear();
                                                },
                                                icon:
                                                    const Icon(Feather.camera))
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Stack(
                                              children: [
                                                Center(
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                          height: 20),
                                                      SizedBox(
                                                          width: 150,
                                                          height: 100,
                                                          child: Image.file(
                                                              imageFile)),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const SizedBox(
                                                            width: 150),
                                                        ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all<Color>(
                                                                        const Color(
                                                                            0xff0C4842)),
                                                                minimumSize:
                                                                    MaterialStateProperty.all<Size>(
                                                                        const Size(
                                                                            30,
                                                                            30)),
                                                                shape: MaterialStateProperty.all<
                                                                        CircleBorder>(
                                                                    const CircleBorder())),
                                                            onPressed: () {
                                                              model
                                                                  .resetImage();
                                                              imageFile = model
                                                                  .imageFile;
                                                            },
                                                            child: const Icon(
                                                                Feather.x)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.5,
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary: const Color(
                                                              0xff0C4842) //ボタンの背景色
                                                          ),
                                                      onPressed: () async {
                                                        await model.pickImage();
                                                        imageFile =
                                                            model.imageFile;
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                              Feather.edit),
                                                          const SizedBox(
                                                              width: 10),
                                                          Text(
                                                            '写真を編集',
                                                            style: GoogleFonts
                                                                .sawarabiMincho(
                                                              color: const Color(
                                                                  0xffFCFAF2),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40, right: 30),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(0xff0C4842),
                                          ),
                                          onPressed: model.isLoading
                                              ? null
                                              : () async {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (imageController.text !=
                                                      null) {
                                                    model.imgURLtext =
                                                        imageController.text;
                                                  }
                                                  if (imageFile != null) {
                                                    model.imageFile = imageFile;
                                                  }
                                                  model.comment =
                                                      commentController.text;
                                                  model.name =
                                                      nameController.text;
                                                  model.url =
                                                      urlController.text;
                                                  try {
                                                    await model.startLoading();
                                                    // ignore: use_build_context_synchronously
                                                    await addTalk(
                                                        model, context);
                                                  } finally {
                                                    if (post != null ) {
                                                      await model.push(
                                                          'あなたのスレにコメがつきました',
                                                          post.mainToken);
                                                    }
                                                    await model.endLoading();
                                                  }
                                                },
                                          child: Text(
                                            '投稿する',
                                            style: GoogleFonts.sawarabiMincho(
                                              color: const Color(0xffFCFAF2),
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            if (model.isLoading)
                              Container(
                                  width: size.width,
                                  height: size.height,
                                  color: Colors.black54,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 250,
                                        height: 250,
                                        child: Image(
                                          image: AssetImage('images/logo.gif'),
                                        ),
                                      ),
                                      Text('〜アップロード中〜',
                                          style: GoogleFonts.sawarabiMincho(
                                            color: const Color(0xffFCFAF2),
                                          )),
                                    ],
                                  ))
                          ],
                        );
                      },
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width * 0.9,
                            child: TextField(
                                style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xff43341B),
                                ),
                                maxLength: 20,
                                controller: nameController,
                                decoration: InputDecoration(
                                  labelText: '名前:名無しさん',
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
                          ),
                          SizedBox(
                            width: size.width * 0.9,
                            child: TextField(
                                style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xff43341B),
                                ),
                                maxLength: 1024,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: commentController,
                                decoration: InputDecoration(
                                  labelText: 'コメント',
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
                          ),
                          SizedBox(
                            width: size.width * 0.9,
                            child: TextField(
                                style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xff43341B),
                                ),
                                maxLength: 2048,
                                controller: urlController,
                                decoration: InputDecoration(
                                  labelText: '関連URL',
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
                          ),
                        ],
                      ),
                    ),
                  ),
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

  Future addTalk(AddTalkModel model, BuildContext context) async {
    try {
      await model.addTalkToFirebase(
          thread, post, count, popID, threadID, uid, upDateAt);
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('投稿しました'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
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
