import 'package:cloud_firestore/cloud_firestore.dart';

class Config {
  Config(DocumentSnapshot doc) {
    config = doc['ios_force_app_version'];
  }
  String? config;
}
