import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_ref_provider.g.dart';

@riverpod
DocumentReference favoriteRef(FavoriteRefRef ref) {
  final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
  return FirebaseFirestore.instance
      .collection('user')
      .doc(uid)
      .collection('favoriteList')
      .doc(uid.substring(25));
}
