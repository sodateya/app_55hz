import 'package:app_55hz/%20presentation/add_post/provider/add_post_provider.dart';
import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddPostPage extends HookConsumerWidget {
  const AddPostPage(
      {super.key, required this.threadId, required this.threadTitle});
  final String threadId;
  final String threadTitle;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addPostProvider);
    final titleController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarBackImg(),
        title: Text(
          '$threadTitle板にスレ立て',
          style: const TextStyle(color: Color(0xffFCFAF2)),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            const BackImg(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                      style: const TextStyle(color: Color(0xff43341B)),
                      maxLength: 64,
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'スレッドのタイトルを入力',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(color: Colors.black54),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: const BorderSide(
                              color: Color(0xff33A6B8), width: 3.0),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0C4842), //ボタンの背景色
                      ),
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              if (titleController.text.trim().isEmpty) {
                                const snackBar =
                                    SnackBar(content: Text('タイトルを入力してください。'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final notifier =
                                    ref.read(addPostProvider.notifier);

                                await notifier
                                    .addPost(threadId, titleController.text)
                                    .then((value) => context.pop(value));
                              }
                            },
                      icon: const Icon(FeatherIcons.edit3),
                      label: const Text('スレッドを投稿する',
                          style: TextStyle(
                            color: Color(0xffFCFAF2),
                          )),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 80),
                const BannerWidget(adSize: AdSize.mediumRectangle)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
