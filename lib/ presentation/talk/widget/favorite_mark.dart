import 'package:app_55hz/%20presentation/favorite/provider/favo_method_provider.dart';
import 'package:app_55hz/%20presentation/favorite/provider/favorite_stream_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteMark extends ConsumerWidget {
  const FavoriteMark(
      {super.key,
      required this.postUid,
      required this.postId,
      required this.threadId,
      required this.title});
  final String postUid;
  final String postId;
  final String threadId;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorite = ref.watch(favoriteStreamDataProvider);
    return favorite.when(data: (data) {
      final isFavorite = data.contains(postId.substring(10));
      return IconButton(
          onPressed: () async {
            ref
                .read(favoMethodProvider.notifier)
                .changeFavo(postId, title, threadId, postUid, isFavorite);
          },
          icon: isFavorite
              ? const Icon(
                  Icons.favorite,
                  color: Color(0xffD0104C),
                )
              : const Icon(
                  Icons.favorite_border,
                  color: Color(0xffFCFAF2),
                ));
    }, error: (__, _) {
      return const SizedBox.square();
    }, loading: () {
      return const SizedBox.square();
    });
  }
}
