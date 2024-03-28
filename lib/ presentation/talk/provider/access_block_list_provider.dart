import 'package:app_55hz/%20presentation/top/provider/ref/post_ref_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'access_block_list_provider.g.dart';

@riverpod
class AccessBlockList extends _$AccessBlockList {
  @override
  Future<List> build(String threadId, String postId) async {
    final doc = await ref.watch(postRefProvider(threadId)).doc(postId).get();
    final accessBlocks = doc.data()?.accessBlock;
    return accessBlocks!;
  }

  /// アクブロ解除
  Future removeAccessBlock(String blockID) async {
    List accessBlockList = [];
    accessBlockList.addAll(state.value!);
    await ref.read(postRefProvider(threadId)).doc(postId).update({
      'accessBlock': FieldValue.arrayRemove([blockID])
    });
    accessBlockList.remove(blockID);
    state = AsyncData(accessBlockList);
  }
}
