import 'dart:io';

import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/talk/provider/ref/talk_ref_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/post_ref_provider.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_talk_provider.g.dart';

@riverpod
class AddTalk extends _$AddTalk {
  @override
  build() {
    return '';
  }

  Future<int> lastCount(String postId, String threadId) async {
    final talk = await ref
        .read(talkRefProvider(postId, threadId))
        .limit(1)
        .orderBy('createdAt', descending: true)
        .get();
    if (talk.docs.isEmpty) {
      return 0;
    } else {
      return talk.docs.first.data().count!;
    }
  }

  Future addTalk(String postId, String threadId, Talk talk, File? imageFile,
      String url, bool isUpdateToday) async {
    state = const AsyncLoading();
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    final doc = ref.read(talkRefProvider(postId, threadId)).doc();

    if (url == '') {
      talk = talk.copyWith(url: url.trim());
    }
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('talk/${doc.id}')
          .putFile(imageFile);
      final imgURL = await task.ref.getDownloadURL();
      talk = talk.copyWith(imgURL: imgURL);
    }
    talk = talk.copyWith(
        uid: uid,
        count: await lastCount(postId, threadId) + 1,
        documentID: doc.id);
    await doc.set(talk);
    await upDatePost(postId, threadId, isUpdateToday);
    state = const AsyncData('');
    return state;
  }

  Future upDatePost(String postId, String threadId, bool isUpdateToday) async {
    final doc = ref.read(postRefProvider(threadId)).doc(postId);
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    doc.update({
      'read': [uid.substring(20)],
      'upDateAt': FieldValue.serverTimestamp(),
      'postCount': isUpdateToday ? FieldValue.increment(1) : 1
    });
  }
}
