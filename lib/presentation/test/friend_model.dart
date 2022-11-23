// ignore_for_file: missing_return

import 'dart:math';

import 'package:app_55hz/presentation/test/friend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FriendModel extends ChangeNotifier {
  List<Friend> userList = [];
  Map<String, dynamic> userInfo = {};

  final firestore = FirebaseFirestore.instance;
  Future getUserList() async {
    final doc = await FirebaseFirestore.instance.collection('userList').get();
    final userLists = doc.docs.map((doc) => Friend(doc)).toList();
    userList = userLists;
    print(userList.first.name);
    notifyListeners();
  }

  Future addUserList() async {
    final room = await FirebaseFirestore.instance.collection('rooms').add({
      'createdAt': Timestamp.now(),
    });
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('userList').doc(user.uid).set({
      'uid': user.uid,
      'name': user.displayName,
      'userImage': user.photoURL,
      'roomID': room.id,
      'accountId': ''
    });
  }

  Future getUserInfo(String uid) async {
    final doc = await firestore.collection('userList').doc(uid).get();
    final userInfos = doc.data();
    userInfo = userInfos;
    notifyListeners();
  }
}
