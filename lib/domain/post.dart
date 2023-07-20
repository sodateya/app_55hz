import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data() ?? {};
    title = data['title'] ?? '';
    final Timestamp timestamp =
        data['createdAt'] as Timestamp? ?? Timestamp.now();
    createdAt = timestamp.toDate();
    final Timestamp upDateAtStamp =
        data['upDateAt'] as Timestamp? ?? Timestamp.now();
    upDateAt = upDateAtStamp.toDate();
    documentID = doc.id;
    uid = data['uid'] ?? '';
    badCount = data['badCount'] as List? ?? [];
    read = data['read'] as List? ?? [];
    accessBlock = data['accessBlock'] as List? ?? [];
    threadId = data['threadId'] ?? '';
    postCount = data['postCount'] as int? ?? 0;
    mainToken = data['mainToken'] ?? '';
  }

  String? title;
  DateTime? createdAt;
  DateTime? upDateAt;
  String? documentID;
  String? uid;
  List? badCount;
  List? read;
  List? accessBlock;
  String? threadId;
  int? postCount;
  String? mainToken;

  Post.fromMap(Map<String, dynamic> data, String documentID) {
    title = data['title'] ?? '';
    final Timestamp timestamp =
        data['createdAt'] as Timestamp? ?? Timestamp.now();
    createdAt = timestamp.toDate();
    final Timestamp upDateAtStamp =
        data['upDateAt'] as Timestamp? ?? Timestamp.now();
    upDateAt = upDateAtStamp.toDate();
    this.documentID = documentID;
    uid = data['uid'] ?? '';
    badCount = data['badCount'] as List? ?? [];
    read = data['read'] as List? ?? [];
    accessBlock = data['accessBlock'] as List? ?? [];
    threadId = data['threadId'] ?? '';
    postCount = data['postCount'] as int? ?? 0;
    mainToken = data['mainToken'] ?? '';
  }
}
