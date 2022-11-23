import 'dart:async';
import 'package:app_55hz/domain/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../domain/post.dart';

class AddThreadModel extends ChangeNotifier {
  String title = '';
  String uid = '';
  String popTitle = '';
  String postID = '';
  Timestamp popCreatedAt;
  bool isLoading = false;
  DateTime upDateAt = DateTime.now();
  String token = '';
  Post post;
  Future startLoading() async {
    isLoading = true;
    notifyListeners();
  }

  Future endLoading() async {
    isLoading = false;
    notifyListeners();
  }

  Future getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    this.token = token;
    notifyListeners();
  }

  Future addThreadToFirebase(Thread thread, String uid, List blockUsers) async {
    final db = FirebaseFirestore.instance
        .collection('thread')
        .doc(thread.documentID)
        .collection('post');
    if (title.isEmpty) {
      throw ('タイトルを入力してください');
    }

    await db.add({
      'title': title,
      'createdAt': Timestamp.now(),
      'upDateAt': Timestamp.now(),
      'uid': uid,
      'badCount': [],
      'read': [],
      'accessBlock': blockUsers,
      'threadId': thread.documentID,
      'postCount': 0,
      'mainToken': token
    }).then((result) {
      popTitle = title;
      postID = result.id;
    });
  }
}
