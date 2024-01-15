import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlockListModel extends ChangeNotifier {
  List blockList = [];
  final firestore = FirebaseFirestore.instance;

  Future fetchBlockList(String uid) async {
    final favoritePost = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .snapshots();
    favoritePost.listen((snapshots) async {
      final blockUsers = await snapshots.data()!['blockUsers'];
      blockList = blockUsers;
      notifyListeners();
    });
  }

  Future removeToBlockList(String uid, String blockUser) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .update({
      'blockUsers': FieldValue.arrayRemove([blockUser])
    });
  }
}
