import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/talk/provider/talk_list_provider.dart';
import 'package:app_55hz/%20presentation/talk/widget/talk_tile/good_button.dart';
import 'package:app_55hz/%20presentation/talk/widget/talk_tile/talk_comment.dart';
import 'package:app_55hz/%20presentation/talk/widget/talk_tile/talk_image.dart';
import 'package:app_55hz/%20presentation/talk/widget/talk_tile/talk_info.dart';
import 'package:app_55hz/%20presentation/talk/widget/talk_tile/talk_url.dart';
import 'package:app_55hz/component/dialog_9ch.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TalkTile extends HookConsumerWidget {
  const TalkTile(
      {super.key,
      required this.talk,
      required this.postUid,
      required this.postId,
      required this.threadId,
      required this.countOnTaped});
  final Talk talk;
  final String postUid;
  final String postId;
  final String threadId;
  final void Function() countOnTaped;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(firebaseAuthInstanceProvider).currentUser!.uid;
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xff43341B).withOpacity(0.3)), //区切り線
        Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            extentRatio: 0.6,
            children: [
              postUid == uid && talk.uid != uid
                  ? SlidableAction(
                      backgroundColor: const Color(0xffD0104C).withOpacity(0.5),
                      label: 'アクブロ',
                      onPressed: (context) {},
                      icon: FeatherIcons.userX)
                  : const SizedBox.shrink(),
              talk.uid == uid
                  ? SlidableAction(
                      backgroundColor: const Color(0xff1C1C1C).withOpacity(0.5),
                      label: '削除',
                      onPressed: (context) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog9ch(
                                title: '削除しますか？',
                                buttonLabel: '削除する',
                                onPressed: () {
                                  final notifier = ref.read(
                                      talkListProvider(postId, threadId)
                                          .notifier);
                                  notifier.deleteTalk(talk.documentID!);

                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      icon: FeatherIcons.trash)
                  : SlidableAction(
                      backgroundColor: const Color(0xffBA9132).withOpacity(0.5),
                      label: '報告',
                      onPressed: (context) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog9ch(
                                title: '違反報告しますか？',
                                buttonLabel: '報告する',
                                onPressed: () {
                                  final notifier = ref.read(
                                      talkListProvider(postId, threadId)
                                          .notifier);
                                  notifier.badAdd(
                                      postId, threadId, talk.documentID!);
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      icon: FeatherIcons.alertTriangle),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TalkInfo(
                talk: talk,
                postUid: postUid,
                countOnTaped: countOnTaped,
              ),
              TalkComment(talk: talk),
              TalkImage(talk: talk),
              TalkUrl(talk: talk)
            ]),
          ),
        ),
        GoodButton(
          talk: talk,
          postId: postId,
          threadId: threadId,
        )
      ],
    );
  }
}
