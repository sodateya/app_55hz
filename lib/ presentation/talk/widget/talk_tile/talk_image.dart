import 'package:app_55hz/%20presentation/gallery/gallery_page.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TalkImage extends ConsumerWidget {
  const TalkImage({super.key, required this.talk});
  final Talk talk;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return talk.imgURL != ''
        ? GestureDetector(
            onTap: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GalleryPage(
                  images: [talk.imgURL!],
                  initialIndex: 0,
                );
              }));
            },
            child: CachedNetworkImage(
              imageUrl: talk.imgURL!,
              fit: BoxFit.fill,
              placeholder: (context, url) => const SizedBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image(
                      image: AssetImage('images/logo.gif'),
                    ),
                  ),
                  Text('〜読み込み中〜',
                      style: TextStyle(color: Color(0xff43341B), fontSize: 21)),
                ],
              )),
            ))
        : const SizedBox.square();
  }
}
