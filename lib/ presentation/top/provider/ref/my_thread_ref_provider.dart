import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/model/thread/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_thread_ref_provider.g.dart';

@riverpod
CollectionReference<Thread> myThreadRef(MyThreadRefRef ref) {
  final uid = ref.watch(firebaseAuthInstanceProvider).currentUser!.uid;
  return FirebaseFirestore.instance
      .collection('user')
      .doc(uid)
      .collection('myThread')
      .withConverter<Thread>(
        fromFirestore: (snapshot, _) => Thread.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
