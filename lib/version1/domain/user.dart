import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User(DocumentSnapshot doc) {
    userID = doc['uid'];
  }
  String? userID;
}
