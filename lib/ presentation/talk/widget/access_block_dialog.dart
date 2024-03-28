import 'package:app_55hz/%20presentation/talk/provider/access_block_list_provider.dart';
import 'package:app_55hz/component/dialog_9ch.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccessBlockDialog extends ConsumerWidget {
  const AccessBlockDialog({
    super.key,
    required this.threadId,
    required this.postId,
  });

  final String threadId;
  final String postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accessBlockListRef =
        ref.watch(accessBlockListProvider(threadId, postId));
    final accessBlockList = accessBlockListRef.when(
        data: (data) => data, error: (_, __) => [], loading: () => []);

    return Dialog(
      backgroundColor: const Color(0xff434343),
      child: SizedBox(
        height: 500,
        child: accessBlockListRef.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (accessBlockList.isNotEmpty)
                    Column(
                      children: [
                        const Text('IDタップで解除できます',
                            style: TextStyle(
                              color: Color(0xffFCFAF2),
                              fontSize: 15.0,
                            )),
                        SizedBox(
                            height: 400,
                            child: ListView.builder(
                              itemCount: accessBlockList.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                return ListTile(
                                  title: Text(
                                      accessBlockList[i]
                                          .toString()
                                          .substring(20),
                                      style: const TextStyle(
                                          color: Color(0xffFCFAF2),
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold)),
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog9ch(
                                            title:
                                                '${accessBlockList[i].toString().substring(20)}を解除しますか？',
                                            buttonLabel: '解除',
                                            onPressed: () async {
                                              await ref
                                                  .read(accessBlockListProvider(
                                                          threadId, postId)
                                                      .notifier)
                                                  .removeAccessBlock(
                                                      accessBlockList[i])
                                                  .then((value) =>
                                                      Navigator.pop(context));
                                            },
                                          );
                                        });
                                  },
                                );
                              },
                            )),
                      ],
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text('ブロックしてるユーザーはいません',
                          style: TextStyle(
                              color: Color(0xffFCFAF2),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0C4842),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      child: const Text('閉じる',
                          style: TextStyle(
                              color: Color(0xffFCFAF2),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold)))
                ],
              ),
      ),
    );
  }
}
