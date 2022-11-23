import 'package:cloud_firestore/cloud_firestore.dart';

class Friend {
  Friend(DocumentSnapshot doc) {
    uid = doc['uid'];
    name = doc['name'];
    photoURL = doc['userImage'];
  }
  String uid;
  String name;
  String photoURL;
}
