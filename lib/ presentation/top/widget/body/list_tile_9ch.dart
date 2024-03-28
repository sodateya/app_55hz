import 'package:app_55hz/%20presentation/block/provider/block_users_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/top/widget/body/read_mark.dart';
import 'package:app_55hz/component/dialog_9ch.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListTile9ch extends HookConsumerWidget {
  const ListTile9ch(
      {super.key,
      required this.posts,
      required this.onPressed,
      required this.onLongPressed,
      this.color = const Color(0xff939650),
      this.isUpdateToday = false});
  final Post posts;
  final void Function()? onPressed;
  final void Function()? onLongPressed;
  final bool isUpdateToday;

  final Color? color;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(firebaseAuthInstanceProvider).currentUser!.uid;
    final postUid = posts.uid!.substring(20);
    return Card(
        child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: const AssetImage('images/washi1.png'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(color!, BlendMode.modulate)),
      ),
      child: Stack(
        children: [
          if (posts.read!.contains(uid.substring(20)))
            const SizedBox()
          else
            const ReadMark(),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.only(top: 17, bottom: 10),
              child: Text(
                posts.title!,
                textAlign: TextAlign.left,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                    color: Color(0xff43341B),
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    minimumSize: MaterialStateProperty.all(Size.zero),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    if (posts.uid != uid) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog9ch(
                              title: '${posts.uid!.substring(20)}をブロックしますか？',
                              buttonLabel: 'ブロックする',
                              onPressed: () {
                                ref
                                    .read(blockUsersProvider.notifier)
                                    .addToBlockList(posts.uid!);
                                Navigator.pop(context);
                              },
                            );
                          });
                    }
                  },
                  child: Text('  ID : $postUid',
                      style: const TextStyle(
                          color: Color(0xffFCFAF2), fontSize: 12.0)),
                ),
                const SizedBox(width: 10),
                Text(
                  '${posts.createdAt!.year}/${posts.createdAt!.month}/${posts.createdAt!.day} ${posts.createdAt!.hour}:${posts.createdAt!.minute}:${posts.createdAt!.second}.${posts.createdAt!.millisecond}',
                  style:
                      const TextStyle(color: Color(0xff43341B), fontSize: 10.0),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isUpdateToday
                    ? Text(
                        '${posts.postCount.toString()}ｺﾒ/日',
                        style: const TextStyle(
                            color: Color(0xff43341B),
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      )
                    : const Text('0ｺﾒ/日',
                        style: TextStyle(
                            color: Color(0xff43341B),
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold))
              ],
            ),
            onTap: onPressed,
            onLongPress: onLongPressed,
          ),
        ],
      ),
    ));
  }
}
