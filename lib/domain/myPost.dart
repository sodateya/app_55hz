// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class MyPost {
  MyPost(DocumentSnapshot doc) {
    postID = doc['docID'];
    final Timestamp timestamp = doc['createdAt'];
    createdAt = timestamp.toDate();
    threadID = doc['threadID'];
    title = doc['title'];
    threadUid = doc['threadUid'];
  }
  String postID;
  DateTime createdAt;
  String threadID;
  String title;
  String threadUid;
}
