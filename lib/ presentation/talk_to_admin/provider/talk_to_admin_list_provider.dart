import 'dart:developer';
import 'dart:io';

import 'package:app_55hz/%20presentation/add_talk/provider/pick_image_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/talk_to_admin/provider/ref/talk_to_admin_ref_provider.dart';
import 'package:app_55hz/model/talk/talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'talk_to_admin_list_provider.g.dart';

@riverpod
class TalkToAdminList extends _$TalkToAdminList {
  @override
  Stream<List<Talk>> build() {
    final doc = ref
        .watch(talkToAdminRefProvider)
        .orderBy('createdAt', descending: true)
        .limit(10)
        .snapshots();

    final list = doc.map((event) => event.docs.map((e) => e.data()).toList());

    return list;
  }

  // Future getTalk() async {
  //   final doc = ref
  //       .watch(talkToAdminRefProvider)
  //       .orderBy('createdAt', descending: true)
  //       .limit(10)
  //       .snapshots();
  //   if (doc.docs.isEmpty) {
  //     state = AsyncValue.error('表示できるレスがありません', StackTrace.current);
  //   } else {
  //     final list = await Future.wait(doc.docs.map((e) async {
  //       final id = e.id;
  //       return e.data().copyWith(documentID: id);
  //     }).toList());
  //     final data = TalkState(talks: list, lastDoc: doc.docs.last);
  //     state = AsyncData(data);
  //   }
  // }

  Future getMoreTalk() async {
    final List<Talk> talks = [];
    talks.addAll(state.value!);

    final doc = await ref
        .read(talkToAdminRefProvider)
        .orderBy('createdAt', descending: true)
        .startAfter([Timestamp.fromDate(talks.last.createdAt!)])
        .limit(10)
        .get();

    try {
      final list = doc.docs.map((e) => e.data()).toList();
      talks.addAll(list);
      state = AsyncData(talks);
    } catch (e) {
      log('終了');
    }
  }

  Future addTalk(Talk talk, File? imageFile) async {
    final isUpload = ref.read(isUploadingPictureProvider.notifier);
    isUpload.startUpload();
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    if (talk.comment!.trim().isNotEmpty) {
      final doc = ref.read(talkToAdminRefProvider).doc();
      talk = talk.copyWith(uid: uid, count: 0, documentID: doc.id);
      await doc.set(talk);
    }
    if (imageFile != null) {
      await addIMage(talk, imageFile, uid);
    }
    isUpload.endUpload();
  }

  Future addIMage(Talk talk, File imageFile, String uid) async {
    final doc = ref.read(talkToAdminRefProvider).doc();
    final task = await FirebaseStorage.instance
        .ref('talk/${doc.id}')
        .putData(await imageFile.readAsBytes());

    final imgURL = await task.ref.getDownloadURL();
    talk = talk.copyWith(
        imgURL: imgURL, uid: uid, count: 0, documentID: doc.id, comment: '');
    doc.set(talk);
    ref.invalidate(pickImageProvider);
  }
}
