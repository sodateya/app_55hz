import 'package:cloud_firestore/cloud_firestore.dart';

import 'post.dart';

class PostAlgolia {
  PostAlgolia(Map<String, dynamic> data) {
    title = data['title'];

    Map<String, dynamic> timestamp = data['createdAt'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(
        (timestamp['_seconds'] * 1000 + timestamp['_nanoseconds'] / 1000000)
            .round());

    Map<String, dynamic> upDateAtStamp = data['upDateAt'];
    upDateAt = DateTime.fromMillisecondsSinceEpoch(
        (upDateAtStamp['_seconds'] * 1000 +
                upDateAtStamp['_nanoseconds'] / 1000000)
            .round());

    documentID =
        data['objectID']; // Algoliaのデータでは、documentIDは通常objectIDとして保存されます。
    uid = data['uid'];
    badCount = data['badCount'];
    read = data['read'];
    accessBlock = data['accessBlock'];
    threadId = data['threadId'];
    postCount = data['postCount'];
    mainToken = data['mainToken'];
    ojId = data['objectID'];
  }
  Post toPost() {
    return Post.fromMap({
      'title': title,
      'createdAt': Timestamp.fromDate(createdAt),
      'upDateAt': Timestamp.fromDate(upDateAt),
      'uid': uid,
      'badCount': badCount,
      'read': read,
      'accessBlock': accessBlock,
      'threadId': threadId,
      'postCount': postCount,
      'mainToken': mainToken,
    }, documentID);
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
  String ojId;
}
