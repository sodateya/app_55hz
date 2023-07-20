// ignore_for_file: missing_return

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/post.dart';

class MyThreadsModel extends ChangeNotifier {
  List<Post> posts = [];
  int documentLimit = 10;
  final firestore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;
  String timeSort = 'createdAt';
  bool? threadSort;
  bool? resSort;

  Future getMyPost(String uid, String sort) async {
    final querySnapshot = await firestore
        .collectionGroup('post')
        .where('uid', whereIn: [uid])
        .orderBy(sort, descending: true)
        .limit(documentLimit)
        .get();
    try {
      lastDocument = querySnapshot.docs.last;
      final myPosts = querySnapshot.docs.map((doc) => Post(doc)).toList();
      posts = myPosts;
      notifyListeners();
    } catch (e) {}
  }

  Future getMoreMyPost(String uid, String sort) async {
    try {
      final docs = await firestore
          .collectionGroup('post')
          .where('uid', whereIn: [uid])
          .orderBy(sort, descending: true)
          .startAfterDocument(lastDocument!)
          .limit(5)
          .get();
      lastDocument = docs.docs.last;
      final myPosts = docs.docs.map((doc) => Post(doc)).toList();
      posts.addAll(myPosts);
      if (kDebugMode) {
        print(posts.length);
      }

      notifyListeners();
    } catch (e) {
      print('終了');
    }
  }

  Future deleteMyThread(String threadID, String postID) async {
    FirebaseFirestore.instance
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(postID)
        .delete();
    notifyListeners();
  }

  Future getConfig() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    threadSort = pref.getBool('threadSort');
    threadSort == false ? timeSort = 'createdAt' : timeSort = 'upDateAt';
    resSort = pref.getBool('resSort');
    notifyListeners();
  }

  Future changeTime() async {
    timeSort == 'createdAt' ? timeSort = 'upDateAt' : timeSort = 'createdAt';
    notifyListeners();
    return timeSort;
  }
}
