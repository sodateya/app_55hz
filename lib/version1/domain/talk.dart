import 'package:cloud_firestore/cloud_firestore.dart';

class Talk {
  Talk(DocumentSnapshot doc) {
    uid = doc['uid'];
    final Timestamp timestamp = doc['createdAt'];
    createdAt = timestamp.toDate();
    documentID = doc.id;
    comment = doc['comment'];
    count = doc['count'];
    badCount = doc['badCount'];
    url = doc['url'];
    name = doc['name'];
    imgURL = doc['imgURL'];
  }
  String? uid;
  DateTime? createdAt;
  String? documentID;
  String? comment;
  int? count;
  List? badCount;
  String? url;
  String? name;
  String? imgURL;
}
