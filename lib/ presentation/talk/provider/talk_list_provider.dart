import 'dart:developer';

import 'package:app_55hz/%20presentation/admob/provider/admob_counter.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/talk/provider/ref/talk_ref_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/post_ref_provider.dart';
import 'package:app_55hz/config/sort/res_sort_provider.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:app_55hz/model/talk/talk_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'talk_list_provider.g.dart';

@riverpod
class TalkList extends _$TalkList {
  @override
  Future<TalkState> build(String postId, String threadId) async {
    if (state.value == null) {
      getTalk(postId, threadId);
    }
    return const TalkState();
  }

  Future getTalk(String postId, String threadId) async {
    final sort = await ref.read(resSortProvider.future);
    final doc = await ref
        .watch(talkRefProvider(postId, threadId))
        .orderBy('createdAt', descending: sort!)
        .limit(13)
        .get();
    if (doc.docs.isEmpty) {
      state = AsyncValue.error('表示できるレスがありません', StackTrace.current);
    } else {
      final list = await Future.wait(doc.docs.map((e) async {
        final id = e.id;
        return e.data().copyWith(documentID: id);
      }).toList());
      final data = TalkState(talks: list, lastDoc: doc.docs.last);
      state = AsyncData(data);
    }
  }

  Future getMoreTalk(String postId, String threadId) async {
    ref.watch(admobCounterProvider.notifier).increment();
    final sort = await ref.read(resSortProvider.future);
    final List<Talk> talks = [];
    talks.addAll(state.value!.talks);
    final doc = await ref
        .watch(talkRefProvider(postId, threadId))
        .orderBy('createdAt', descending: sort!)
        .startAfterDocument(state.value!.lastDoc!)
        .limit(10)
        .get();
    try {
      final list = await Future.wait(doc.docs.map((e) async {
        final id = e.id;
        return e.data().copyWith(documentID: id);
      }).toList());
      talks.addAll(list);
      final data = TalkState(talks: talks, lastDoc: doc.docs.last);
      state = AsyncData(data);
    } catch (e) {
      log('終了');
    }
  }

  ///スライドメソッド

  /// トーク削除
  Future deleteTalk(String documentID) async {
    await ref.read(talkRefProvider(postId, threadId)).doc(documentID).delete();
    final List<Talk> talks = [];
    talks.addAll(state.value!.talks);
    talks.removeWhere((talk) => talk.documentID == documentID);
    final data = TalkState(talks: talks, lastDoc: state.value!.lastDoc);
    state = AsyncData(data);
  }

  /// アクブロ
  Future accessBlock(String postId, String threadId, String blockID) async {
    await ref.read(postRefProvider(threadId)).doc(postId).update({
      'accessBlock': FieldValue.arrayUnion([blockID])
    });
  }

  /// アクブロ解除
  Future removeAccessBlock(
      String postId, String threadId, String blockID) async {
    await ref.read(postRefProvider(threadId)).doc(postId).update({
      'accessBlock': FieldValue.arrayRemove([blockID])
    });
  }

  /// 通報
  Future badAdd(String postId, String threadId, String documentID) async {
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    await ref.read(talkRefProvider(postId, threadId)).doc(documentID).update({
      'badCount': FieldValue.arrayUnion([uid])
    });
  }
}
