import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/talk/provider/good_talk_provider.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GoodButton extends HookConsumerWidget {
  GoodButton({
    super.key,
    required this.talk,
    required this.postId,
    required this.threadId,
  });
  final Talk talk;
  final String postId;
  final String threadId;
  final List list = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    list.addAll(talk.good ?? []);
    final goodListState = useState<List<dynamic>>(list);
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () async {
                if (goodListState.value.contains(uid)) {
                  await ref
                      .read(goodTalkProvider.notifier)
                      .removeGood(postId, threadId, talk.documentID!);
                  goodListState.value = [...goodListState.value..remove(uid)];
                } else {
                  await ref
                      .read(goodTalkProvider.notifier)
                      .addGood(postId, threadId, talk.documentID!);
                  goodListState.value = [...goodListState.value..add(uid)];
                }
              },
              icon: goodListState.value.contains(uid)
                  ? const Icon(Icons.thumb_up_alt)
                  : const Icon(Icons.thumb_up_off_alt)),
          Text(goodListState.value.length.toString())
        ],
      ),
    );
  }
}
