import 'package:app_55hz/config/firebase_instance_provider.dart';
import 'package:app_55hz/model/user/user_9ch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_db_ref_provider.g.dart';

@riverpod
CollectionReference<User9ch> UserDbRef(UserDbRefRef ref) {
  return ref
      .watch(firebaseFirestoreInstanceProvider)
      .collection('user')
      .withConverter<User9ch>(
        fromFirestore: (ds, _) => User9ch.fromJson(ds.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
}
