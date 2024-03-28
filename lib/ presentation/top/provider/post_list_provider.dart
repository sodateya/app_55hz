import 'package:app_55hz/%20presentation/admob/provider/admob_counter.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/all_post_ref.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/post_ref_provider.dart';
import 'package:app_55hz/config/sort/thread_sort_provider.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:app_55hz/model/post/post_state.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_list_provider.g.dart';

@riverpod
class PostListProvider extends _$PostListProvider {
  @override
  Future<PostState> build(Thread thread) async {
    if (state.value == null) {
      getPostSelect(thread);
    }
    return const PostState();
  }

  Future getPostSelect(Thread thread) {
    switch (thread.title) {
      case 'すべて':
        return getAllPost();

      case '今日のトピック':
        return getUpdateToday();

      default:
        return getPost(thread);
    }
  }

  Future getMoreSelect(Thread thread) {
    ref.watch(admobCounterProvider.notifier).increment();
    switch (thread.title) {
      case 'すべて':
        return getMoreAllPost();

      case '今日のトピック':
        return getMoreUpdateToday();

      default:
        return getMorePost(thread);
    }
  }

  Future getPost(Thread thread) async {
    final sort = await ref.read(threadSortProvider.future);

    final doc = await ref
        .watch(postRefProvider(thread.documentID!))
        .orderBy(sort!, descending: true)
        .limit(10)
        .get();
    final list = await Future.wait(doc.docs.map((e) async {
      final id = e.id;
      return e.data().copyWith(documentID: id);
    }).toList());

    if (list.isNotEmpty) {
      state = AsyncData(PostState(posts: list, lastDoc: doc.docs.last));
    } else {
      state = AsyncValue.error('表示できるスレッドがありません。', StackTrace.current);
    }
  }

  Future getMorePost(Thread thread) async {
    final sort = await ref.read(threadSortProvider.future);

    final List<Post> posts = [];
    posts.addAll(state.value!.posts);
    final doc = await ref
        .watch(postRefProvider(thread.documentID!))
        .orderBy(sort!, descending: true)
        .startAfterDocument(state.value!.lastDoc!)
        .limit(10)
        .get();

    try {
      final list = await Future.wait(doc.docs.map((e) async {
        final id = e.id;
        return e.data().copyWith(documentID: id);
      }).toList());
      posts.addAll(list);
      final data = PostState(posts: posts, lastDoc: doc.docs.last);
      state = AsyncData(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future getAllPost() async {
    final sort = await ref.read(threadSortProvider.future);

    final doc = await ref
        .watch(allPostRefProvider)
        .orderBy(sort!, descending: true)
        .limit(10)
        .get();
    final list = await Future.wait(doc.docs.map((e) async {
      final id = e.id;
      return e.data().copyWith(documentID: id);
    }).toList());
    if (list.isNotEmpty) {
      state = AsyncData(PostState(posts: list, lastDoc: doc.docs.last));
    } else {
      state = AsyncValue.error('表示できるスレッドがありません。', StackTrace.current);
    }
  }

  Future getMoreAllPost() async {
    final sort = await ref.read(threadSortProvider.future);

    final List<Post> posts = [];
    posts.addAll(state.value!.posts);
    final doc = await ref
        .watch(allPostRefProvider)
        .orderBy(sort!, descending: true)
        .startAfterDocument(state.value!.lastDoc!)
        .limit(10)
        .get();
    try {
      final list = await Future.wait(doc.docs.map((e) async {
        final id = e.id;
        return e.data().copyWith(documentID: id);
      }).toList());
      posts.addAll(list);
      final data = PostState(posts: posts, lastDoc: doc.docs.last);
      state = AsyncData(data);
    } catch (e) {
      print('終了');
    }
  }

  Future getUpdateToday() async {
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final doc = await ref
        .watch(allPostRefProvider)
        .orderBy('upDateAt', descending: true)
        .where('upDateAt', isGreaterThanOrEqualTo: today)
        .limit(10)
        .get();
    final list = await Future.wait(doc.docs.map((e) async {
      final id = e.id;
      return e.data().copyWith(documentID: id);
    }).toList());
    if (list.isNotEmpty) {
      state = AsyncData(PostState(posts: list, lastDoc: doc.docs.last));
    } else {
      state = AsyncValue.error('表示できるスレッドがありません。', StackTrace.current);
    }
  }

  Future getMoreUpdateToday() async {
    DateTime today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final List<Post> posts = [];
    posts.addAll(state.value!.posts);
    final doc = await ref
        .watch(allPostRefProvider)
        .orderBy('upDateAt', descending: true)
        .where('upDateAt', isGreaterThanOrEqualTo: today)
        .startAfterDocument(state.value!.lastDoc!)
        .limit(10)
        .get();
    try {
      final list = await Future.wait(doc.docs.map((e) async {
        final id = e.id;
        return e.data().copyWith(documentID: id);
      }).toList());
      posts.addAll(list);
      final data = PostState(posts: posts, lastDoc: doc.docs.last);
      state = AsyncData(data);
    } catch (e) {
      print('終了');
    }
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
    final data = PostState(posts: posts, lastDoc: state.value!.lastDoc);
    state = AsyncData(data);
  }

  Future deleteMyThread(String threadId, String postId) async {
    await ref.read(postRefProvider(threadId)).doc(postId).delete();
    final List<Post> posts = [];
    posts.addAll(state.value!.posts);
    posts.removeWhere((post) => post.documentID == postId);
    final data = PostState(posts: posts, lastDoc: state.value!.lastDoc);
    state = AsyncData(data);
  }
}
