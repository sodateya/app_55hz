import 'package:app_55hz/domain/blockUsers.dart';
import 'package:app_55hz/domain/post_algolia.dart';
import 'package:app_55hz/domain/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:algolia/algolia.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;
import 'package:shared_preferences/shared_preferences.dart';

class SearchModel extends ChangeNotifier {
  bool? resSort;

  List favoriteList = [];
  List<BlockUsers> blockUser = [];
  int documentLimit = 10;
  final firestore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;
  DateFormat formattedTime = DateFormat('yyyy/MM/dd/HH:mm');
  int search = 0;
  bool isLoading = false;
  List<PostAlgolia> posts = [];
  Algolia algolia = const Algolia.init(
    applicationId: 'YUUAZI2TQ1',
    apiKey: '5431dfbb535f387c9f09f5c1ec89a751',
  );

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    // notifyListeners();
  }

  Future searchAlgolia(String queryString, int page) async {
    if (search == 0) {
      startLoading();
    }
    AlgoliaQuery query = algolia.instance
        .index('9ch_posts')
        .query(queryString)
        .setHitsPerPage(15)
        .setPage(search);

    var results = await query.getObjects();

    for (var record in results.hits) {
      Map<String, dynamic> dataMap = record.data;
      PostAlgolia post = PostAlgolia(dataMap);
      posts.add(post);
    }
    if (search == 0) {
      endLoading();
    }
    notifyListeners();
  }

  Future getConfig() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    resSort = pref.getBool('resSort');
    notifyListeners();
  }

  // ignore: missing_return
  Future badAdd(Thread thread, String postDocumentID, String uid) async {
    FirebaseFirestore.instance
        .collection('thread')
        .doc(thread.documentID)
        .collection('post')
        .doc(postDocumentID)
        .update({
      'badCount': FieldValue.arrayUnion([uid])
    });
    notifyListeners();
  }

  // ignore: missing_return
  Future deleteMyThread(Thread thread, String postDocID) async {
    FirebaseFirestore.instance
        .collection('thread')
        .doc(thread.documentID)
        .collection('post')
        .doc(postDocID)
        .delete();
    notifyListeners();
  }

  // ignore: missing_return
  Future addToBlockList(String uid, String blockUser) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .update({
      'blockUsers': FieldValue.arrayUnion([blockUser])
    });
  }

  // ignore: missing_return
  Future removeToBlockList(String uid, String blockUser) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .update({
      'blockUsers': FieldValue.arrayRemove([blockUser])
    });
  }

  Future fetchBlockList(String uid) async {
    final favoritePost = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .snapshots();
    favoritePost.listen((snapshots) async {
      final blockUsers = snapshots.docs.map((doc) => BlockUsers(doc)).toList();
      blockUser = blockUsers;
      notifyListeners();
    });
  }
}
