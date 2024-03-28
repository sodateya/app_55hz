import 'package:app_55hz/%20presentation/block/provider/block_users_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/post_ref_provider.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_post_provider.g.dart';

@riverpod
class AddPost extends _$AddPost {
  @override
  Future<Post?> build() async {
    return const Post();
  }

  Future<Post> addPost(String threadId, String title) async {
    if (title.trim().isEmpty) {
      throw Exception('タイトルを入力してください。');
    }
    final blockList = ref.read(blockUsersProvider).value;
    state = const AsyncLoading();
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    final doc = ref.watch(postRefProvider(threadId)).doc();
    final post = Post(
        title: title,
        createdAt: DateTime.now(),
        upDateAt: DateTime.now(),
        documentID: doc.id,
        uid: uid,
        badCount: [],
        read: [uid],
        accessBlock: blockList,
        threadId: threadId,
        postCount: 0,
        mainToken: '');
    await doc.set(post);
    state = AsyncData(post);
    return post;
  }
}
