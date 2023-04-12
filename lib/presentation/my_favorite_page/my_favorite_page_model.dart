import 'package:app_55hz/domain/myPost.dart';
import 'package:app_55hz/domain/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFavoritePageModel extends ChangeNotifier {
  List<MyPost> myPost = [];
  int documentLimit = 10;
  final firestore = FirebaseFirestore.instance;
  DocumentSnapshot lastDocument;
  List blockList = [];
  Post post;

  Future getBlockList(String uid) async {
    final querySnapshot = await firestore
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .get();
    final abList = await querySnapshot.data()['blockUsers'];
    blockList = abList;
    notifyListeners();
  }

  Future getMyFavorite(String uid) async {
    final querySnapshot = await firestore
        .collection('user')
        .doc(uid)
        .collection('favoritePost')
        .orderBy('createdAt', descending: true)
        .limit(documentLimit)
        .get();
    try {
      lastDocument = querySnapshot.docs.last;
      final myPosts = querySnapshot.docs.map((doc) => MyPost(doc)).toList();
      myPost = myPosts;
      notifyListeners();
    } catch (e) {
      print('NoFavo');
    }
  }

  Future getMoreMyFavorite(String uid) async {
    try {
      final docs = await firestore
          .collection('user')
          .doc(uid)
          .collection('favoritePost')
          .orderBy('createdAt', descending: true)
          .startAfterDocument(lastDocument)
          .limit(5)
          .get();
      lastDocument = docs.docs.last;
      final myPosts = docs.docs.map((doc) => MyPost(doc)).toList();
      myPost.addAll(myPosts);
      print(myPost.length);
      notifyListeners();
    } catch (e) {
      print('終了');
    }
  }

  Future<Post> getThreadData(String threadID, String postID) async {
    final doc = await firestore
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(postID)
        .get();
    post = Post(doc);
    return post;
  }

  Future deleteFavorite(
    String uid,
    String documentID,
  ) async {
    await firestore
        .collection('user')
        .doc(uid)
        .collection('favoritePost')
        .doc(documentID)
        .delete();
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favoriteList')
        .doc(uid.substring(25))
        .update({
      'favoriteThreads': FieldValue.arrayRemove([documentID.substring(10)])
    });
  }
}
