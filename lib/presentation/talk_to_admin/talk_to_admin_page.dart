// ignore_for_file: must_be_immutable, missing_return

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../main/admob.dart';
import 'talk_to_admin_model.dart';

File imageFile;
TextEditingController commentController = TextEditingController();

class TalkToAdminPage extends StatelessWidget {
  TalkToAdminPage({Key key, this.uid, this.adInterstitial}) : super(key: key);

  AdInterstitial adInterstitial;
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId,
    request: const AdRequest(),
  )..load();
  String uid;
  final adominUid = 'rerVaRIZp9Zo9HTu8iwySUWAmi02';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return ChangeNotifierProvider.value(
      value: TalkToAdminModel()
        ..getTalk()
        ..getName(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              flexibleSpace: const Image(
                image: AssetImage('images/washi1.png'),
                fit: BoxFit.cover,
                color: Color(0xff2d3441),
                colorBlendMode: BlendMode.modulate,
              ),
              leading: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Feather.chevron_left,
                      color: Color(0xfffbecd6),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              title: Text('管理人とお話し',
                  style: GoogleFonts.sawarabiMincho(
                      color: const Color(0xffFCFAF2)))),
          backgroundColor: const Color(0xffFCFAF2),
          body: Consumer<TalkToAdminModel>(builder: (context, model, child) {
            final talks = model.talks;
            // ignore: no_leading_underscores_for_local_identifiers
            ScrollController _scrollController = ScrollController();
            Future getMore() async {
              if (_scrollController.position.pixels ==
                  _scrollController.position.maxScrollExtent) {
                await model.getMoreTalk();
                adInterstitial.counter++;
              }
            }

            return Stack(
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
                  height: size.height,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 64,
                        child: AdWidget(
                          ad: banner,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                            reverse: true,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            cacheExtent: 9999,
                            controller: _scrollController..addListener(getMore),
                            itemCount: talks.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (talks[index].uid == adominUid) {
                                return adminsTalk(
                                    context, size, talks, index, model, uid);
                              } else {
                                return otheresTalk(
                                    context, size, talks, index, model, uid);
                              }
                            },
                          ),
                        ),
                      ),
                      imageFile == null
                          ? const SizedBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: 150,
                                      height: 100,
                                      child: Image.file(imageFile)),
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          await model.resetImage();
                                          imageFile = model.imageFile;
                                        },
                                        icon: const Icon(FontAwesome.trash_o)),
                                    IconButton(
                                        onPressed: () async {
                                          await model.pickImage();
                                          imageFile = model.imageFile;
                                        },
                                        icon: const Icon(FontAwesome.edit)),
                                  ],
                                )
                              ],
                            ),
                    ],
                  ),
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
          }),
          bottomNavigationBar:
              Consumer<TalkToAdminModel>(builder: (context, model, child) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff2d3441),
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          const Color(0xff2d3441).withAlpha(0),
                          BlendMode.dstATop),
                      image: const AssetImage('images/washi1.png'),
                      fit: BoxFit.fill,
                    )),
                height: size.height * 0.12,
                child: Center(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await model.pickImage();
                            imageFile = model.imageFile;
                            print(model.imageFile);
                          },
                          icon: const Icon(
                            Feather.image,
                            color: Color(0xffFCFAF2),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: size.height * 0.1,
                          width: size.width * 0.7,
                          child: TextField(
                              onChanged: (value) => model.comment = value,
                              style: GoogleFonts.sawarabiMincho(
                                fontSize: 12,
                                color: const Color(0xffFCFAF2),
                              ),
                              maxLength: 128,
                              controller: commentController,
                              decoration: InputDecoration(
                                counterStyle: GoogleFonts.sawarabiMincho(
                                    color: const Color(0xffFCFAF2)),
                                labelText: 'メッセージを入力',
                                alignLabelWithHint: true,
                                labelStyle: GoogleFonts.sawarabiMincho(
                                    color: const Color(0xffFCFAF2)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xffFCFAF2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Color(0xffFCFAF2), width: 3.0),
                                ),
                              )),
                        ),
                      ),
                      model.isLoading
                          ? const SizedBox()
                          : IconButton(
                              onPressed: model.isLoading
                                  ? null
                                  : () async {
                                      addComment(context, model, uid);
                                    },
                              icon: const Icon(
                                Feather.send,
                                color: Color(0xffFCFAF2),
                              ))
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

Widget adminsTalk(BuildContext context, size, List talks, int index,
    TalkToAdminModel model, String uid) {
  return GestureDetector(
    onLongPress: () async => uid == model.adominUid
        ? await deleteAdd(model, context, talks[index])
        : null,
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    '管理人(亜ッラー)',
                    style: GoogleFonts.sawarabiMincho(
                        color: const Color(0xff4f535a), fontSize: 8),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    talks[index].comment == ''
                        ? const SizedBox()
                        : Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0x0fffbed6)),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xfffbecd6),
                              ),
                              child: Text(
                                talks[index].comment,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xff4f535a),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                        '${talks[index].createdAt.year}/${talks[index].createdAt.month}/${talks[index].createdAt.day} ${talks[index].createdAt.hour}:${talks[index].createdAt.minute}',
                        style: GoogleFonts.sawarabiMincho(
                            color: const Color(0xff4f535a), fontSize: 7.0),
                        textAlign: TextAlign.left),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              talks[index].imgURL == ''
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SizedBox(
                        width: size.width * 0.8,
                        child: GestureDetector(
                            onTap: () async {
                              launch(talks[index].imgURL);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: Image.network(
                                    talks[index].imgURL,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget otheresTalk(BuildContext context, size, List talks, int index,
    TalkToAdminModel model, String uid) {
  return GestureDetector(
    onLongPress: () async => talks[index].uid == uid || uid == model.adominUid
        ? await deleteAdd(model, context, talks[index])
        : null,
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                  width: size.width * 0.8,
                  child: Text(
                    '${talks[index].name} (${talks[index].uid.substring(20)})',
                    style: GoogleFonts.sawarabiMincho(
                        color: const Color(0xff4f535a), fontSize: 8),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        '${talks[index].createdAt.year}/${talks[index].createdAt.month}/${talks[index].createdAt.day} ${talks[index].createdAt.hour}:${talks[index].createdAt.minute}',
                        style: GoogleFonts.sawarabiMincho(
                            color: const Color(0xff4f535a), fontSize: 7.0),
                        textAlign: TextAlign.left),
                    const SizedBox(width: 5),
                    Flexible(
                      child: talks[index].comment == ''
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xff2d3441)),
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff2d3441),
                              ),
                              child: Text(
                                talks[index].comment,
                                textAlign: TextAlign.left,
                                style: GoogleFonts.sawarabiMincho(
                                  color: const Color(0xffFCFAF2),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              talks[index].imgURL == ''
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: SizedBox(
                        width: size.width * 0.8,
                        child: GestureDetector(
                            onTap: () async {
                              launch(talks[index].imgURL);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: Image.network(
                                    talks[index].imgURL,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
            ],
          ),
        ],
      ),
    ),
  );
}

Future addComment(
    BuildContext context, TalkToAdminModel model, String uid) async {
  model.comment = commentController.text;
  if (imageFile != null) {
    model.imageFile = imageFile;
  }
  try {
    model.startLoading();
    await model.addThreadToFirebase(uid);
  } catch (e) {
    final snackBar = SnackBar(
      backgroundColor: const Color(0xffD0104C),
      content: Text(e.toString()),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } finally {
    FocusScope.of(context).unfocus();
    imageFile = null;
    model.comment = null;
    commentController
      ..clearComposing()
      ..clear();
    model.endLoading();
  }
}

Future deleteAdd(TalkToAdminModel model, BuildContext context, dynamic talk) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black54,
        title: Text(
          '投稿を削除しますか？',
          style: GoogleFonts.sawarabiMincho(
              color: const Color(0xffFCFAF2),
              fontSize: 15.0,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Text('いいえ',
                    style: GoogleFonts.sawarabiMincho(
                        color: const Color(0xff33A6B8),
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('はい',
                    style: GoogleFonts.sawarabiMincho(
                        color: const Color(0xff33A6B8),
                        fontWeight: FontWeight.bold)),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await model.deleteAdd(talk);
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
