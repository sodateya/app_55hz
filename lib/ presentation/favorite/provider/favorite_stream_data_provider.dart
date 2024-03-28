import 'dart:developer';

import 'package:app_55hz/%20presentation/favorite/provider/favorite_ref_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_stream_data_provider.g.dart';

@riverpod
Stream<List> favoriteStreamData(FavoriteStreamDataRef ref) {
  return ref.watch(favoriteRefProvider).snapshots().map((event) {
    // DocumentSnapshotからデータを取り出す
    final data = event.data() as Map<String, dynamic>?;

    // 'favoriteThreads'フィールドが存在するか確認し、リストとして取り出す
    final blockUsers = data?['favoriteThreads'] as List?;

    // 'favoriteThreads'フィールドが存在しない場合は空リストを返す
    return blockUsers ?? [];
  }).handleError((error) {
    log('Error fetching favoriteThreads: $error');
    return [];
  });
}
