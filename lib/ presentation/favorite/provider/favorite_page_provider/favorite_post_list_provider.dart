import 'package:app_55hz/%20presentation/admob/provider/admob_counter.dart';
import 'package:app_55hz/%20presentation/favorite/provider/favorite_page_provider/favorite_ref_provider.dart';
import 'package:app_55hz/%20presentation/favorite/provider/favorite_ref_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/post_ref_provider.dart';
import 'package:app_55hz/model/favorite/favorite_state.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_post_list_provider.g.dart';

@riverpod
class FavoritePostList extends _$FavoritePostList {
  @override
  Future<FavoriteState> build() async {
    if (state.value == null) {
      getPost();
    }
    return const FavoriteState();
  }

  Future getPost() async {
    final doc = await ref
        .watch(favoritePostDataRefProvider)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .get();
    final list = doc.docs.map((e) => e.data()).toList();
    state = const AsyncLoading();
    if (list.isNotEmpty) {
      List<Post> posts = [];
      for (var post in list) {
        final doc = await ref
            .read(postRefProvider(post.threadID))
            .doc(post.docID)
            .get();
        if (doc.data() == null) {
          await ref.read(favoriteRefProvider).update({
            'favoriteThreads':
                FieldValue.arrayRemove([post.docID.substring(10)])
          });
          await ref.read(favoritePostDataRefProvider).doc(post.docID).delete();
        } else {
          final data = doc.data();
          final postData = data!.copyWith(documentID: post.docID);
          posts.add(postData);
        }
      }
      state = AsyncData(FavoriteState(posts: posts, lastDoc: doc.docs.last));
    } else {
      state = AsyncValue.error('表示できるスレッドがありません。', StackTrace.current);
    }
  }

  Future getMorePost() async {
    ref.watch(admobCounterProvider.notifier).increment();
    final List<Post> posts = [];
    posts.addAll(state.value!.posts);
    final doc = await ref
        .watch(favoritePostDataRefProvider)
        .orderBy('createdAt', descending: true)
        .startAfterDocument(state.value!.lastDoc!)
        .limit(10)
        .get();
    try {
      final list = doc.docs.map((e) => e.data()).toList();
      for (var post in list) {
        final doc = await ref
            .read(postRefProvider(post.threadID))
            .doc(post.docID)
            .get();

        final data = doc.data();
        final postData = data!.copyWith(documentID: post.docID);
        posts.add(postData);
      }

      final data = FavoriteState(posts: posts, lastDoc: doc.docs.last);
      state = AsyncData(data);
    } catch (e) {}
  }

  Future readPost(Post post, int i) async {
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    List read = [uid.substring(20)];
    read.addAll(post.read!);
    List<Post> posts = [];

    posts.addAll(state.value!.posts);
    await ref
        .watch(postRefProvider(post.threadId!))
        .doc(post.documentID)
        .update({
      'read': FieldValue.arrayUnion([uid.substring(20)])
    });
    posts[i] = posts[i].copyWith(read: read);
    final data = FavoriteState(posts: posts, lastDoc: state.value!.lastDoc);
    state = AsyncData(data);
  }
}
