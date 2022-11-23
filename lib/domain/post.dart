import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post(DocumentSnapshot doc) {
    title = doc['title'];
    final Timestamp timestamp = doc['createdAt'];
    createdAt = timestamp.toDate();
    final Timestamp upDateAtStamp = doc['upDateAt'];
    upDateAt = upDateAtStamp.toDate();
    documentID = doc.id;
    uid = doc['uid'];
    badCount = doc['badCount'];
    read = doc['read'];
    accessBlock = doc['accessBlock'];
    threadId = doc['threadId'];
    postCount = doc['postCount'];
    mainToken = doc['mainToken'];
  }
  String title;
  DateTime createdAt;
  DateTime upDateAt;
  String documentID;
  String uid;
  List badCount;
  List read;
  List accessBlock;
  String threadId;
  int postCount;
  String mainToken;
}
