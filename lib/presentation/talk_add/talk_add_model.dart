// ignore_for_file: missing_return

import 'dart:async';
import 'dart:io';
import 'package:app_55hz/domain/post.dart';
import 'package:app_55hz/domain/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTalkModel extends ChangeNotifier {
  String comment = '';
  String url = '';
  String name = '';
  File imageFile;
  final picker = ImagePicker();
  bool isLoading = false;
  String imgURLtext;
  String mainToken;
  bool isUpdateToday(DateTime upDateAt) {
    final isUpdateToday = '${upDateAt.year}/${upDateAt.month}/${upDateAt.day}' ==
        '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}';
    return isUpdateToday;
  }

  Future startLoading() {
    isLoading = true;
    notifyListeners();
  }

  Future endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    name = pref.getString('handleName');
    notifyListeners();
  }

  Future addTalkToFirebase(Thread thread, Post post, int count, String popID,
      String threadID, String uid, DateTime upDateAt) async {
    if (comment.isEmpty) {
      throw ('コメントを入力してください');
    }

    threadID ??= thread.documentID;
    popID ??= post.documentID;
    final doc = FirebaseFirestore.instance
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(popID)
        .collection('talk')
        .doc();

    String imgURL;
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('talk/${doc.id}')
          .putFile(imageFile);
      imgURL = await task.ref.getDownloadURL();
    }

    await doc.set({
      'comment': comment,
      'createdAt': Timestamp.now(),
      'uid': uid,
      'count': count + 1,
      'badCount': [],
      'url': url.trim(),
      'name': name,
      'imgURL': imgURL ?? imgURLtext.trim(),
    });
    FirebaseFirestore.instance
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(popID)
        .update({
      'read': [uid.substring(20)],
      'upDateAt': Timestamp.now(),
      'postCount': isUpdateToday(upDateAt) ? FieldValue.increment(1) : 1
    });
  }

  Future getMainToken(String threadID, String popID) async {
    final doc = await FirebaseFirestore.instance
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(popID)
        .get();
    mainToken = doc.data()['mainToken'];
    notifyListeners();
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future resetImage() {
    imageFile = null;
    notifyListeners();
  }

  Future push(String text, String token) async {
    final functions = FirebaseFunctions.instanceFor(region: 'asia-northeast1');
    final callable = functions.httpsCallable('pushSubmitFromApp');
    await callable({'id': text, 'token': token});
    notifyListeners();
  }
}
