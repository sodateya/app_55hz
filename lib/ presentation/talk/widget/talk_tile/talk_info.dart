import 'package:app_55hz/%20presentation/block/provider/block_users_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/component/dialog_9ch.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class TalkInfo extends ConsumerWidget {
  const TalkInfo(
      {super.key,
      required this.talk,
      required this.postUid,
      required this.countOnTaped});
  final Talk talk;
  final String postUid;
  final void Function() countOnTaped;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = DateFormat('yyyy/MM/dd hh:mm:ss:S');
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
                onTap: countOnTaped,
                child: Text(talk.count.toString(),
                    style: const TextStyle(color: Color(0xff43341B)))),
            Text(': ${talk.name == '' ? '名無しさん' : talk.name}',
                style: const TextStyle(color: Color(0xff43341B))),
            const SizedBox(width: 8),
            postUid == talk.uid
                ? const Text('(主)',
                    style: TextStyle(color: Color(0xff2EA9DF), fontSize: 8.0))
                : const SizedBox.shrink(),
          ],
        ),
        Row(
          children: [
            Text(
              formatter.format(talk.createdAt!),
              style: const TextStyle(color: Color(0xff43341B), fontSize: 10.0),
            ),
            const SizedBox(width: 8),
            InkWell(
              child: Text('ID : ${talk.uid!.substring(20)}',
                  style:
                      const TextStyle(color: Color(0xff2EA9DF), fontSize: 10)),
              onTap: () {
                if (talk.uid != uid) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog9ch(
                          title: '${talk.uid!.substring(20)}をブロックしますか？',
                          buttonLabel: 'ブロックする',
                          onPressed: () {
                            ref
                                .read(blockUsersProvider.notifier)
                                .addToBlockList(talk.uid!);
                            Navigator.pop(context);
                          },
                        );
                      });
                }
              },
            )
          ],
        ),
      ],
    );
  }
}
