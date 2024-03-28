import 'package:app_55hz/router/enum/router_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchDialog extends HookConsumerWidget {
  const SearchDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();
    return AlertDialog(
      title: TextField(
        controller: searchController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: const InputDecoration(
          labelText: '検索ワード',
        ),
      ),
      actions: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('閉じる')),
                TextButton(
                    onPressed: () async {
                      context.pop(context);
                      context.push(
                          '${RouteConfig.top.path}/${RouteConfig.searchPage.path}',
                          extra: searchController.text);

                      // await Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SearchPage(
                      //               adInterstitial: widget.adInterstitial,
                      //               uid: widget.uid,
                      //               searchWord: widget.con.text,
                      //             )));
                    },
                    child: const Text('検索')),
              ],
            ),
          ],
        )
      ],
    );
  }
}
