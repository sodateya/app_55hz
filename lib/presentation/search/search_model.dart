// import 'package:app_55hz/domain/blockUsers.dart';
// import 'package:app_55hz/domain/post.dart';
// import 'package:app_55hz/domain/thread.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class SearchModel extends ChangeNotifier {
//   List<Thread> threads = [];
//   List<Post> posts = [];
//   List favoriteList = [];
//   List<BlockUsers> blockUser = [];
//   int documentLimit = 10;
//   final firestore = FirebaseFirestore.instance;
//   DocumentSnapshot lastDocument;

//   Future fetchThread() async {
//     final docs = await FirebaseFirestore.instance
//         .collection('thread')
//         .orderBy('createdAt', descending: true)
//         .get();
//     final threads = docs.docs.map((doc) => Thread(doc)).toList();
//     this.threads = threads;
//     notifyListeners();
//   }

//   Future getSearchPost(Thread thread, String searchWord) async {
//     final querySnapshot = await firestore
//         .collection('thread')
//         .doc(thread.documentID)
//         .collection('post')
//         .orderBy('title')
//         .startAt([searchWord])
//         .endAt(['$searchWord\uf8ff'])
//         .limit(documentLimit)
//         .get();
//     try {
//       lastDocument = querySnapshot.docs.last;
//       final posts = querySnapshot.docs.map((doc) => Post(doc)).toList();
//       posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//       this.posts = posts;
//       notifyListeners();
//       // ignore: empty_catches
//     } catch (e) {}
//   }

//   Future getMoreSearchPost(Thread thread, String searchWord) async {
//     try {
//       final docs = await firestore
//           .collection('thread')
//           .doc(thread.documentID)
//           .collection('post')
//           .orderBy('title')
//           .startAt([searchWord])
//           .endAt(['$searchWord\uf8ff'])
//           .startAfterDocument(lastDocument)
//           .limit(5)
//           .get();
//       lastDocument = docs.docs.last;
//       final posts = docs.docs.map((doc) => Post(doc)).toList();
//       posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//       this.posts.addAll(posts);
//       print(this.posts.length);
//       notifyListeners();
//     } catch (e) {
//       throw ('スレッドがありません');
//     }
//   }

//   // ignore: missing_return
//   Future badAdd(Thread thread, String postDocumentID, String uid) {
//     FirebaseFirestore.instance
//         .collection('thread')
//         .doc(thread.documentID)
//         .collection('post')
//         .doc(postDocumentID)
//         .update({
//       'badCount': FieldValue.arrayUnion([uid])
//     });
//     notifyListeners();
//   }

//   // ignore: missing_return
//   Future deleteMyThread(Thread thread, String postDocID) {
//     FirebaseFirestore.instance
//         .collection('thread')
//         .doc(thread.documentID)
//         .collection('post')
//         .doc(postDocID)
//         .delete();
//     notifyListeners();
//   }

//   // ignore: missing_return
//   Future addToBlockList(String uid, String blockUser) {
//     FirebaseFirestore.instance
//         .collection('user')
//         .doc(uid)
//         .collection('blockList')
//         .doc(uid.substring(20))
//         .update({
//       'blockUsers': FieldValue.arrayUnion([blockUser])
//     });
//   }

//   // ignore: missing_return
//   Future removeToBlockList(String uid, String blockUser) {
//     FirebaseFirestore.instance
//         .collection('user')
//         .doc(uid)
//         .collection('blockList')
//         .doc(uid.substring(20))
//         .update({
//       'blockUsers': FieldValue.arrayRemove([blockUser])
//     });
//   }

//   Future fetchBlockList(String uid) async {
//     final favoritePost = FirebaseFirestore.instance
//         .collection('user')
//         .doc(uid)
//         .collection('blockList')
//         .snapshots();
//     favoritePost.listen((snapshots) async {
//       final blockUsers = snapshots.docs.map((doc) => BlockUsers(doc)).toList();
//       blockUser = blockUsers;
//       notifyListeners();
//     });
//   }
// }
