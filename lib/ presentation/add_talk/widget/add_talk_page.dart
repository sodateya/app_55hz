import 'package:app_55hz/%20presentation/add_talk/provider/add_talk_provider.dart';
import 'package:app_55hz/%20presentation/add_talk/provider/pick_image_provider.dart';
import 'package:app_55hz/%20presentation/add_talk/widget/image_widget/picked_image_9ch.dart';
import 'package:app_55hz/%20presentation/add_talk/widget/send_talk_button.dart';
import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/edit_profile/provider/my_name_provider.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:app_55hz/component/loading_9ch.dart';
import 'package:app_55hz/component/text_form_9ch.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddTalkPage extends HookConsumerWidget {
  const AddTalkPage(
      {super.key,
      this.resNumber,
      required this.postId,
      required this.threadId,
      required this.isUpdateToday});

  final String? resNumber;
  final String postId;
  final String threadId;
  final bool isUpdateToday;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final nameController = useTextEditingController();
    final urlController = useTextEditingController();
    final imageUrlController = useTextEditingController();
    final image = ref.watch(pickImageProvider);
    final name = ref.watch(myNameProvider).value ?? '';
    nameController.text =
        nameController.text == '' ? name : nameController.text;
    if (commentController.text == '' && resNumber != 'null') {
      commentController.text = '>>$resNumber';
    }
    final addState = ref.watch(addTalkProvider);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarBackImg(),
        title: const Text(
          'レスポンス',
          style: TextStyle(color: Color(0xffFCFAF2)),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            const BackImg(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextForm9ch(
                            labelText: '名前:名無しさん',
                            controller: nameController,
                            maxLength: 20,
                            maxLines: 1)),
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextForm9ch(
                            labelText: 'コメント',
                            controller: commentController,
                            maxLength: 1024)),
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextForm9ch(
                            labelText: '関連URL',
                            controller: urlController,
                            maxLength: 2048)),
                    Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextForm9ch(
                            labelText: '画像URL',
                            controller: imageUrlController,
                            maxLength: 2048,
                            suffixIcon: IconButton(
                                icon: const Icon(FeatherIcons.camera),
                                onPressed: () {
                                  final notifier =
                                      ref.read(pickImageProvider.notifier);
                                  notifier.pickImage();
                                }))),
                    image != null
                        ? PickedImage9ch(image: image)
                        : const SizedBox.shrink(),
                    SendTalkButton(
                      onPressed: () async {
                        if (commentController.text.trim().isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  title: const Text('コメントを入力してください',
                                      style: TextStyle(fontSize: 16)),
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('閉じる')),
                                    )
                                  ],
                                );
                              });
                        } else {
                          final talk = Talk(
                              createdAt: DateTime.now(),
                              comment: commentController.text,
                              badCount: [],
                              imgURL: '',
                              name: nameController.text);
                          await ref
                              .read(addTalkProvider.notifier)
                              .addTalk(postId, threadId, talk, image,
                                  urlController.text, isUpdateToday)
                              .then((value) => context.pop(value));
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const BannerWidget(
                      adSize: AdSize.largeBanner,
                    )
                  ],
                ),
              ),
            ),
            addState == const AsyncLoading()
                ? const Loading9ch()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
