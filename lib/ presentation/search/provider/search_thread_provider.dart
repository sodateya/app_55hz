import 'package:algolia/algolia.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/search/provider/search_loading_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/post_ref_provider.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_thread_provider.g.dart';

@riverpod
class SearchThread extends _$SearchThread {
  @override
  Future<List<Post>> build(String queryString) async {
    if (state.value == null) {
      searchAlgolia(queryString);
    }
    return [];
  }

  Algolia algolia = const Algolia.init(
    applicationId: 'YUUAZI2TQ1',
    apiKey: '5431dfbb535f387c9f09f5c1ec89a751',
  );

  Future searchAlgolia(String queryString) async {
    state = const AsyncLoading();

    List<Post> posts = [];
    AlgoliaQuery query = algolia.instance
        .index('9ch_posts')
        .query(queryString)
        .setHitsPerPage(10)
        .setPage(0);

    var results = await query.getObjects();

    for (var record in results.hits) {
      Map<String, dynamic> resultData = record.data;
      final threadId = resultData['threadId'];
      final postId = resultData['objectID']; //なぜかドキュメントIDがないものがあるからobjectIDを使う
      final doc = await ref.read(postRefProvider(threadId)).doc(postId).get();
      final data = doc.data();
      final post = data!.copyWith(documentID: postId);
      posts.add(post);
    }

    state = AsyncData(posts);
  }

  Future moreSearchAlgolia(int page) async {
    ref.read(searchLoadingProvider.notifier).startLoading();

    List<Post> posts = [];
    posts.addAll(state.value!);
    AlgoliaQuery query = algolia.instance
        .index('9ch_posts')
        .query(queryString)
        .setHitsPerPage(10)
        .setPage(page);

    var results = await query.getObjects();

    for (var record in results.hits) {
      Map<String, dynamic> resultData = record.data;
      final threadId = resultData['threadId'];
      final postId = resultData['objectID']; //なぜかドキュメントIDがないものがあるからobjectIDを使う
      final doc = await ref.read(postRefProvider(threadId)).doc(postId).get();
      final data = doc.data();
      final post = data!.copyWith(documentID: postId);
      posts.add(post);
    }

    state = AsyncData(posts);
    ref.read(searchLoadingProvider.notifier).endLoading();
  }

  Future readPost(Post post, int i) async {
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    List read = [uid.substring(20)];
    read.addAll(post.read!);
    List<Post> posts = [];

    posts.addAll(state.value!);
    await ref
        .watch(postRefProvider(post.threadId!))
        .doc(post.documentID)
        .update({
      'read': FieldValue.arrayUnion([uid.substring(20)])
    });
    posts[i] = posts[i].copyWith(read: read);

    state = AsyncData(posts);
  }
}
