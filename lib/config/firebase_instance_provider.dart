import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_instance_provider.g.dart';

@riverpod
FirebaseFirestore firebaseFirestoreInstance(FirebaseFirestoreInstanceRef ref) {
  return FirebaseFirestore.instance;
}
