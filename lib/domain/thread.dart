import 'package:cloud_firestore/cloud_firestore.dart';

class Thread {
  Thread(DocumentSnapshot doc) {
    title = doc['title'];
    final Timestamp timestamp = doc['createdAt'];
    createdAt = timestamp.toDate();
    documentID = doc.id;
  }
  String title;
  DateTime createdAt;
  String documentID;
}
