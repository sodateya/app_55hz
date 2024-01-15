// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class BlockUsers {
  BlockUsers(DocumentSnapshot doc) {
    blockUsers = doc['blockUsers'];
  }
  List? blockUsers;
}
