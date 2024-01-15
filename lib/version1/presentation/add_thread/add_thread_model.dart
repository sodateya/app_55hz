import 'dart:async';

import 'package:app_55hz/version1/domain/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/post.dart';

class AddThreadModel extends ChangeNotifier {
  String title = '';
  String uid = '';
  String popTitle = '';
  String postID = '';
  Timestamp? popCreatedAt;
  bool isLoading = false;
  DateTime upDateAt = DateTime.now();
  String token = '';
  Post? post;
  bool? resSort;

  Future startLoading() async {
    isLoading = true;
    notifyListeners();
  }

  Future endLoading() async {
    isLoading = false;
    notifyListeners();
  }

  Future getResSort() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    resSort = pref.getBool('resSort');
    return resSort;
  }

  Future addThreadToFirebase(Thread thread, String uid, List blockUsers) async {
    final token = await FirebaseMessaging.instance.getToken();

    final db = FirebaseFirestore.instance
        .collection('thread')
        .doc(thread.documentID)
        .collection('post');
    if (title.isEmpty) {
      throw ('タイトルを入力してください');
    }

    await db.add({
      'title': title,
      'createdAt': FieldValue.serverTimestamp(),
      'upDateAt': FieldValue.serverTimestamp(),
      'uid': uid,
      'badCount': [],
      'read': [],
      'accessBlock': blockUsers,
      'threadId': thread.documentID,
      'postCount': 0,
      'mainToken': token
    }).then((result) async {
      final doc = await result.get();
      post = Post(doc);
    });
  }
}
