import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() ?? {};
    title = data['title'];
    final Timestamp timestamp = data['createdAt'];
    createdAt = timestamp.toDate();
    final Timestamp upDateAtStamp = data['upDateAt'];
    upDateAt = upDateAtStamp.toDate();
    documentID = doc.id;
    uid = data['uid'];
    badCount = data['badCount'];
    read = data['read'];
    accessBlock = data['accessBlock'];
    threadId = data['threadId'];
    postCount = data['postCount'];
    mainToken = data['mainToken'];
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
