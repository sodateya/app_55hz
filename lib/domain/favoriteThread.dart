// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteThread {
  FavoriteThread(DocumentSnapshot doc) {
    favoriteThreads = doc['favoriteThreads'];
  }
  List favoriteThreads;
}
