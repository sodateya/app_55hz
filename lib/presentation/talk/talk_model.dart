// ignore_for_file: missing_return

import 'package:app_55hz/domain/favoriteThread.dart';
import 'package:app_55hz/domain/myPost.dart';
import 'package:app_55hz/domain/post.dart';
import 'package:app_55hz/domain/talk.dart';
import 'package:app_55hz/domain/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TalkModel extends ChangeNotifier {
  List<Thread> threads = [];
  List<Post> posts = [];
  List<Talk> talks = [];
  List<MyPost> myPost = [];
  List blockUser = [];
  List<FavoriteThread> favoriteThread = [];
  List accessBlockList = [];
  final firestore = FirebaseFirestore.instance;
  int documentLimit = 13;
  DocumentSnapshot? lastDocument;
  bool? reverse;

  Future getResSort() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    reverse = pref.getBool('resSort');
    notifyListeners();
  }

  Future changeReverse() async {
    reverse == true ? reverse = false : reverse = true;
    notifyListeners();
  }

  Future getTalk(Post post, bool resSort, String uid) async {
    if (reverse == null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      final reverse = pref.getBool('resSort');
      this.reverse = reverse;
      notifyListeners();
    }
    final querySnapshot = await firestore
        .collection('thread')
        .doc(post.threadId)
        .collection('post')
        .doc(post.documentID)
        .collection('talk')
        .orderBy('createdAt', descending: reverse!)
        .limit(documentLimit)
        .get();
    try {
      lastDocument = querySnapshot.docs.last;
      final talks = querySnapshot.docs.map((doc) => Talk(doc)).toList();
      this.talks = talks;
    } catch (e) {
      print(e);
    }
    if (post.uid == uid) {
      final doc = await FirebaseFirestore.instance
          .collection('thread')
          .doc(post.threadId)
          .collection('post')
          .doc(post.documentID)
          .get();
      final abList = doc.data()!['accessBlock'];
      accessBlockList = abList;
    }
    notifyListeners();
  }

  Future getMoreTalk(Post post) async {
    try {
      final docs = await firestore
          .collection('thread')
          .doc(post.threadId)
          .collection('post')
          .doc(post.documentID)
          .collection('talk')
          .orderBy('createdAt', descending: reverse!)
          .limit(documentLimit)
          .startAfterDocument(lastDocument!)
          .limit(15)
          .get();
      lastDocument = docs.docs.last;
      final talks = docs.docs.map((doc) => Talk(doc)).toList();
      this.talks.addAll(talks);
      notifyListeners();
    } catch (e) {
      print('終了');
    }
  }

  Future fetchMyFavorite(String uid) async {
    final favoritePost = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favoriteList')
        .snapshots();
    favoritePost.listen((snapshots) async {
      final favoriteThreads =
          snapshots.docs.map((doc) => FavoriteThread(doc)).toList();
      favoriteThread = favoriteThreads;
      notifyListeners();
    });
  }

  Future addFavorite(String uid, Post post) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favoriteList')
        .doc(uid.substring(25))
        .update({
      'favoriteThreads': FieldValue.arrayUnion([post.documentID!.substring(10)])
    });
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favoritePost')
        .doc(post.documentID)
        .set({
      'title': post.title,
      'docID': post.documentID,
      'createdAt': Timestamp.now(),
      'threadID': post.threadId,
      'threadUid': post.uid
    });
    notifyListeners();
  }

  Future deleteFavorite(String uid, Post post) async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favoriteList')
        .doc(uid.substring(25))
        .update({
      'favoriteThreads':
          FieldValue.arrayRemove([post.documentID!.substring(10)])
    });
    final docs = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favoritePost')
        .doc(post.documentID);
    docs.delete();
    notifyListeners();
  }

  Future badAdd(Post post, Talk talk, String uid) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(post.threadId)
        .collection('post')
        .doc(post.documentID)
        .collection('talk')
        .doc(talk.documentID)
        .update({
      'badCount': FieldValue.arrayUnion([uid])
    });
    notifyListeners();
  }

  Future deleteAdd(Post post, Talk talk) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(post.threadId)
        .collection('post')
        .doc(post.documentID)
        .collection('talk')
        .doc(talk.documentID)
        .delete();
    notifyListeners();
  }

  Future fetchBlockList(String uid) async {
    final favoritePost = FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('blockList')
        .doc(uid.substring(20))
        .snapshots();
    favoritePost.listen((snapshots) async {
      final blockUsers = await snapshots.data()!['blockUsers'];
      blockUser = blockUsers;
    });
  }

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

  Future removeToFavorite(String uid, String favoID) async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('favoriteList')
        .doc(uid.substring(25))
        .update({
      'favoriteThreads': FieldValue.arrayRemove([favoID])
    });
  }

  Future getAccessBlock(String threadID, String postID) async {
    final doc = await FirebaseFirestore.instance
        .collection('thread')
        .doc(threadID)
        .collection('post')
        .doc(postID)
        .get();
    final abList = doc.data()!['accessBlock'];
    accessBlockList = abList;
    print(abList);
    notifyListeners();
  }

  Future addAccsessBlock(
      BuildContext context, Post post, String blockID) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(post.threadId)
        .collection('post')
        .doc(post.documentID)
        .update({
      'accessBlock': FieldValue.arrayUnion([blockID])
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('${blockID.substring(20)}\nのアクセスをブロックしました',
              style:
                  GoogleFonts.sawarabiMincho(color: const Color(0xffFCFAF2))),
          actions: [
            TextButton(
              child: const Text('閉じる'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    print('ok');
    notifyListeners();
  }

  Future removeAccsessBlock(
      BuildContext context, Post post, String blockID) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(post.threadId)
        .collection('post')
        .doc(post.documentID)
        .update({
      'accessBlock': FieldValue.arrayRemove([blockID])
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text('${blockID.substring(20)}\nのアクセスブロックを解除しました',
              style:
                  GoogleFonts.sawarabiMincho(color: const Color(0xffFCFAF2))),
          actions: [
            TextButton(
              child: const Text('閉じる'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    notifyListeners();
  }
}
