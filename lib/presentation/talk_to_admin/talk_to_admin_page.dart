// ignore: unused_import
import 'dart:io';
import 'package:app_55hz/domain/custom_cache_manager.dart';
import 'package:app_55hz/main/admob.dart';
import 'package:app_55hz/presentation/talk_to_admin/picture_page.dart';
import 'package:app_55hz/presentation/talk_to_admin/talk_to_admin_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

File? imageFile;

TextEditingController commentController = TextEditingController();

// ignore: must_be_immutable
class TalkToAdminPage extends StatelessWidget {
  TalkToAdminPage(
      {super.key,
      required this.uid,
      required this.adInterstitial,
      required this.size});
  Size size;
  AdInterstitial adInterstitial;
  BannerAd banner = BannerAd(
    listener: const BannerAdListener(),
    size: AdSize.banner,
    adUnitId: AdInterstitial.bannerAdUnitId!,
    request: const AdRequest(),
  )..load();
  String uid;
  final adominUid = 'rerVaRIZp9Zo9HTu8iwySUWAmi02';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TalkToAdminModel>(
        create: (context) => TalkToAdminModel()
          ..getTalk()
          ..getName(),
        child: Builder(builder: (ctx) {
          return GestureDetector(
            onTap: () => FocusScope.of(ctx).unfocus(),
            child: Scaffold(
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/washi1.png'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Color(0xff2d3441),
                          BlendMode.modulate,
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: const Color(0xff2d3441),
                  title: Text('管理人とお話し',
                      style: GoogleFonts.sawarabiMincho(
                          color: const Color(0xffFCFAF2))),
                ),
                body: Consumer<TalkToAdminModel>(
                    builder: (context, model, child) {
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
                        height: size.height,
                        width: size.width,
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
                      Column(
                        children: [
                          SizedBox(
                            height: 64,
                            child: AdWidget(
                              ad: banner,
                            ),
                          ),
                          Expanded(
                              child: ListView.builder(
                                  controller: _scrollController
                                    ..addListener(getMore),
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  reverse: true,
                                  cacheExtent: 9999,
                                  shrinkWrap: true,
                                  itemCount: model.talks.length,
                                  itemBuilder: (ctx, index) {
                                    return talks[index].uid == adominUid
                                        ? adminsTalk(
                                            ctx, size, talks, index, model, uid)
                                        : otheresTalk(ctx, size, talks, index,
                                            model, uid);
                                  })),
                          InputForm(ctx, model, uid, size),
                          const SizedBox(height: 20)
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
                            )),
                    ],
                  );
                })),
          );
        }));
  }
}

Widget adminsTalk(BuildContext context, Size size, List talks, int index,
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
                        ? const SizedBox.shrink()
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
                  ? const SizedBox.shrink()
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
                                  child: CachedNetworkImage(
                                    imageUrl: talks[index].imgURL,
                                    fit: BoxFit.fill,
                                    cacheManager: customCacheManager,
                                    placeholder: (context, url) => SizedBox(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          child: Image(
                                            image:
                                                AssetImage('images/logo.gif'),
                                          ),
                                        ),
                                        Text('〜読み込み中〜',
                                            style: GoogleFonts.sawarabiMincho(
                                              color: const Color(0xff0000),
                                            )),
                                      ],
                                    )),
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
    model.comment = '';
    commentController
      ..clearComposing()
      ..clear();
    model.endLoading();
  }
}

Future deleteAdd(
    TalkToAdminModel model, BuildContext context, dynamic talk) async {
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

Widget otheresTalk(BuildContext context, Size size, List talks, int index,
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
                          ? const SizedBox.shrink()
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
                  ? const SizedBox.shrink()
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
                                  child: CachedNetworkImage(
                                    imageUrl: talks[index].imgURL,
                                    fit: BoxFit.fill,
                                    cacheManager: customCacheManager,
                                    placeholder: (context, url) => SizedBox(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          child: Image(
                                            image:
                                                AssetImage('images/logo.gif'),
                                          ),
                                        ),
                                        Text('〜読み込み中〜',
                                            style: GoogleFonts.sawarabiMincho(
                                              color: const Color(0xff0000),
                                            )),
                                      ],
                                    )),
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

Widget InputForm(
    BuildContext context, TalkToAdminModel model, String uid, Size size) {
  return Container(
    alignment: Alignment.bottomCenter,
    margin: const EdgeInsets.all(15.0),
    child: IntrinsicHeight(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.photo_camera, color: Colors.blueAccent),
                onPressed: () async {
                  await model.pickImage().then((value) => value != null
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PicturePage(
                              ontap: () async {
                                await model.addImage(
                                  uid,
                                );
                              },
                              imageFile: model.imageFile!,
                              size: size,
                            ),
                            fullscreenDialog: true,
                          ))
                      : print(value));
                },
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Scrollbar(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: TextField(
                            maxLines: 10,
                            minLines: 1,
                            onChanged: (value) {
                              model.comment = value;
                            },
                            controller: commentController,
                            decoration: const InputDecoration(
                                hintText: "メッセージを入力...",
                                hintStyle: TextStyle(color: Colors.blueAccent),
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              model.isLoading == false
                  ? IconButton(
                      icon: const Icon(Icons.send, color: Colors.blueAccent),
                      onPressed: () async {
                        try {
                          model.startLoading();
                          await model.addThreadToFirebase(uid);
                        } catch (e) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(milliseconds: 1000),
                            margin: const EdgeInsets.only(
                              bottom: 40,
                            ),
                            content: Text(
                              e.toString(),
                              textAlign: TextAlign.center,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } finally {
                          model.endLoading();
                        }
                        commentController.clear();
                        model.comment = '';
                        model.imageFile = null;
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          )
        ],
      ),
    ),
  );
}
