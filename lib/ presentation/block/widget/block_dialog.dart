import 'package:app_55hz/%20presentation/block/provider/block_users_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BlockDialog extends ConsumerWidget {
  const BlockDialog(
      {super.key, required this.partnerUid, this.isRemove = false});
  final String partnerUid;
  final bool isRemove;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: isRemove
          ? Text(
              '${partnerUid.substring(20)}\nのブロックを解除しますか？',
              style: const TextStyle(fontSize: 16),
            )
          : Text(
              '${partnerUid.substring(20)}をブロックしますか？',
              style: const TextStyle(fontSize: 16),
            ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('キャンセル')),
        TextButton(
            onPressed: () {
              final notifier = ref.read(blockUsersProvider.notifier);
              isRemove
                  ? notifier.removeToBlockList(partnerUid)
                  : notifier.addToBlockList(partnerUid);
              Navigator.pop(context);
            },
            child: Text(
              isRemove ? 'ブロック解除' : 'ブロックする',
              style: const TextStyle(
                  color: Color(0xffD0104C), fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
