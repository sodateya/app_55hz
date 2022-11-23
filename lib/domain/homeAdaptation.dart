// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeAdaptation {
  HomeAdaptation(DocumentSnapshot doc) {
    homeAdaptation = doc['homeAdaptation'];
  }
  bool homeAdaptation;
}
