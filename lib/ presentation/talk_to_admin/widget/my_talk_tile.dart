import 'package:app_55hz/%20presentation/gallery/gallery_page.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyTalkTile extends ConsumerWidget {
  const MyTalkTile({super.key, required this.talk});

  final Talk talk;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTime = talk.createdAt!;
    String date = "${dateTime.year}/${dateTime.month}/${dateTime.day}";
    String time =
        "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";

    return GestureDetector(
      onLongPress: () {
        print('pon');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(date,
                        style: const TextStyle(
                            fontSize: 8, // 年月日のフォントサイズ
                            color: Color(0xff000000))),
                    Row(
                      children: [
                        Text(time,
                            style: const TextStyle(
                                fontSize: 8, // 年月日のフォントサイズ
                                color: Color(0xff000000))),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                talk.comment == ''
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return GalleryPage(
                              images: [talk.imgURL!],
                              initialIndex: 0,
                            );
                          }));
                        },
                        child: Center(
                            child: SizedBox(
                          width: 160,
                          height: 160,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: talk.imgURL!,
                              fit: BoxFit.contain,
                              placeholder: (context, url) => const SizedBox(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 128,
                                    height: 128,
                                    child: Image(
                                      image: AssetImage('images/logo.gif'),
                                    ),
                                  ),
                                  Text('〜読み込み中〜',
                                      style: TextStyle(
                                          color: Color(0xff43341B),
                                          fontSize: 16)),
                                ],
                              )),
                            ),
                          ),
                        )
                            // SizedBox(
                            //   width: 160,
                            //   height: 160,
                            //   child: ClipRRect(
                            //     borderRadius: BorderRadius.circular(8),
                            //     child: talk.imgURL != ""
                            //         ? Image.network(
                            //             talk.imgURL!,
                            //             fit: BoxFit.cover,
                            //           )
                            //         : Container(),
                            //   ),
                            // ),
                            ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SizedBox(
                              child: Text(
                                '${talk.name} (${talk.uid!.substring(20)})',
                                style: const TextStyle(
                                    color: Color(0xff4f535a), fontSize: 8),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xff2d3441)),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: 16.0,
                                  right: 16.0),
                              child: Column(
                                children: [
                                  Text(
                                    talk.comment!,
                                    style: const TextStyle(
                                        color: Color(0xffFCFAF2),
                                        fontWeight: FontWeight.bold),
                                    softWrap: true,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}