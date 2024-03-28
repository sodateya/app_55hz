import 'package:app_55hz/%20presentation/admob/provider/interstitial/interstitial_9ch_provider.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CategoryFab extends ConsumerWidget {
  const CategoryFab({super.key, required this.thread});
  final Thread thread;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: FloatingActionButton.extended(
        heroTag: null,
        elevation: 9,
        label: Row(children: [
          Column(children: [
            Text('${thread.title}板',
                style: const TextStyle(
                    color: Color(0xffFCFAF2),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold)),
            const Text('に追加',
                style: TextStyle(
                    color: Color(0xffFCFAF2),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold))
          ]),
          const SizedBox(width: 15),
          const Icon(FeatherIcons.edit, color: Color(0xffFCFAF2))
        ]),
        backgroundColor: const Color(0xff0C4842).withOpacity(0.7),
        onPressed: () async {
          ref.read(interstitial9chProvider.notifier).createAd();
          await context
              .push(
                  '${RouteConfig.top.path}/${RouteConfig.addPost.path}/${thread.documentID}/${thread.title}')
              .then((value) {
            if (value != null) {
              value as Post;
              context.push(
                  '${RouteConfig.top.path}/${RouteConfig.talk.path}/${value.uid}/${value.threadId}/${value.documentID}',
                  extra: [value.title, true]);
            }
          });
        },
      ),
    );
  }
}
