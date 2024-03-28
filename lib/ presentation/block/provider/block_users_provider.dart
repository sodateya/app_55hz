import 'package:app_55hz/%20presentation/block/provider/block_ref_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'block_users_provider.g.dart';

@riverpod
class BlockUsers extends _$BlockUsers {
  @override
  Stream<List?> build() {
    return ref.watch(blockRefProvider).snapshots().map((event) {
      // DocumentSnapshotからデータを取り出す
      final data = event.data() as Map<String, dynamic>?;

      // 'blockUsers'フィールドが存在するか確認し、リストとして取り出す
      final blockUsers = data?['blockUsers'] as List?;

      // 'blockUsers'フィールドが存在しない場合は空リストを返す
      return blockUsers ?? [];
    }).handleError((error) {
      return [];
    });
  }

  Future removeToBlockList(String blockUser) async {
    await ref.read(blockRefProvider).update({
      'blockUsers': FieldValue.arrayRemove([blockUser])
    });
  }

  Future addToBlockList(String blockUser) async {
    await ref.read(blockRefProvider).update({
      'blockUsers': FieldValue.arrayUnion([blockUser])
    });
  }
}
