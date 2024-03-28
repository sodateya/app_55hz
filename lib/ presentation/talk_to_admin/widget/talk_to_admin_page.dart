import 'package:app_55hz/%20presentation/admob/widget/banner_widget.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/provider/talk_to_admin_list_provider.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/widget/admin_talk_tile.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/widget/my_talk_tile.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/widget/send_tool/send_message_tools.dart';
import 'package:app_55hz/component/back_img.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TalkToAdminPage extends HookConsumerWidget {
  const TalkToAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final talk = ref.watch(talkToAdminListProvider);

    return Scaffold(
      appBar: AppBar(
          flexibleSpace: const AppBarBackImg(
            color: Color(0xff2d3441),
          ),
          title: const Text('管理人とお話し',
              style: TextStyle(color: Color.fromRGBO(252, 250, 242, 1)))),
      body: Stack(
        children: [
          const BackImg(),
          talk.when(data: (data) {
            ScrollController scrollController = useScrollController();
            Future getMore() async {
              if (scrollController.position.pixels ==
                  scrollController.position.maxScrollExtent) {
                final notifier = ref.read(talkToAdminListProvider.notifier);
                await notifier.getMoreTalk();
              }
            }

            final talks = data;
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Expanded(
                    child: data.isEmpty
                        ? const Center(
                            child: Text('表示できるトークがありません'),
                          )
                        : GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: ListView.builder(
                                controller: scrollController
                                  ..addListener(getMore),
                                shrinkWrap: true,
                                reverse: true, //新しいものが下に来るよう設定
                                itemCount: talks.length,
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      talks[i].uid ==
                                              'rerVaRIZp9Zo9HTu8iwySUWAmi02'
                                          ? AdminTalkTile(talk: talks[i])
                                          : MyTalkTile(talk: talks[i]),
                                      i == 0
                                          ? const SizedBox(height: 64)
                                          : const SizedBox.shrink()
                                    ],
                                  );
                                }),
                          ),
                  ),
                ],
              ),
            );
          }, error: (__, _) {
            return Center(child: Text(__.toString()));
          }, loading: () {
            return const Center(child: CircularProgressIndicator());
          }),
          const BannerWidget(adSize: AdSize.fullBanner),
          const SendMessageTools(),
        ],
      ),
    );
  }
}
