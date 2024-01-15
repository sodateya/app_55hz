// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:app_55hz/version1/domain/post.dart';
import 'package:app_55hz/version1/main/admob.dart';
import 'package:app_55hz/version1/presentation/talk_add/talk_add_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

class AddTalkPage extends StatelessWidget {
  Post post;
  String uid;
  String? resNumber;
  int count;
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  File? imageFile;
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();

  AddTalkPage(
      {super.key,
      required this.post,
      required this.uid,
      this.resNumber,
      required this.count});

  @override
  Widget build(BuildContext context) {
    if (commentController.text == '' && resNumber != null) {
      commentController.text = '>>$resNumber';
    }
    final Size size = MediaQuery.of(context).size;
    final bottomSpace = MediaQuery.of(context).viewInsets.bottom;
    return ChangeNotifierProvider<AddTalkModel>(
      create: (context) => AddTalkModel()..getName(),
      child: Scaffold(
        backgroundColor: const Color(0xffFCFAF2),
        resizeToAvoidBottomInset: false,
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
          title: const Text(
            'レスポンス',
            style: TextStyle(
                color: Color(0xffFCFAF2),
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            Container(
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
                      nameController.text == ''
                          ? nameController.text = model.name
                          : nameController.text = nameController.text;
                      return Stack(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              child!,
                              Container(
                                child: imageFile == null
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.75,
                                            child: TextFormField(
                                                style: const TextStyle(
                                                  color: Color(0xff43341B),
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
                                                            color:
                                                                Colors.black54),
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
                                              icon: const Icon(
                                                  FeatherIcons.camera))
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Center(
                                                child: Column(
                                                  children: [
                                                    const SizedBox(height: 20),
                                                    SizedBox(
                                                        width: 150,
                                                        height: 100,
                                                        child: Image.file(
                                                            imageFile!)),
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
                                                                          30, 30)),
                                                              shape: MaterialStateProperty.all<
                                                                      CircleBorder>(
                                                                  const CircleBorder())),
                                                          onPressed: () {
                                                            model.resetImage();
                                                            imageFile =
                                                                model.imageFile;
                                                          },
                                                          child: const Icon(
                                                              FeatherIcons.x)),
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
                                                        backgroundColor:
                                                            const Color(
                                                                0xff0C4842) //ボタンの背景色
                                                        ),
                                                    onPressed: () async {
                                                      await model.pickImage();
                                                      imageFile =
                                                          model.imageFile;
                                                    },
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(FeatherIcons.edit),
                                                        SizedBox(width: 10),
                                                        Text(
                                                          '写真を編集',
                                                          style: TextStyle(
                                                            color: Color(
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
                                          backgroundColor:
                                              const Color(0xff0C4842),
                                        ),
                                        onPressed: model.isLoading
                                            ? null
                                            : () async {
                                                // ignore: unnecessary_null_comparison
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
                                                model.url = urlController.text;

                                                try {
                                                  await addTalk(model, context);
                                                } catch (e) {
                                                  model.endLoading();
                                                }
                                              },
                                        child: const Text(
                                          '投稿する',
                                          style: TextStyle(
                                            color: Color(0xffFCFAF2),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          model.isLoading
                              ? Container(
                                  width: size.width,
                                  height: size.height,
                                  color: Colors.black54,
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        height: 250,
                                        child: Image(
                                          image: AssetImage('images/logo.gif'),
                                        ),
                                      ),
                                      Text('〜アップロード中〜',
                                          style: TextStyle(
                                            color: Color(0xffFCFAF2),
                                          )),
                                    ],
                                  ))
                              : const SizedBox.shrink()
                        ],
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width * 0.9,
                          child: TextField(
                              style: const TextStyle(
                                color: Color(0xff43341B),
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
                              style: const TextStyle(
                                color: Color(0xff43341B),
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
                              style: const TextStyle(
                                color: Color(0xff43341B),
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
    );
  }

  Future addTalk(AddTalkModel model, BuildContext context) async {
    if (model.comment != '') {
      await model.addTalkToFirebase(post, uid, count);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('投稿しました'),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () async {
                  await model.endLoading();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      const snackBar = SnackBar(
        backgroundColor: Color(0xffD0104C),
        content: Text('コメントを入力してください'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
