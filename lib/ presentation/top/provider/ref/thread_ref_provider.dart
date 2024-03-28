import 'package:app_55hz/model/thread/thread.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'thread_ref_provider.g.dart';

@riverpod
CollectionReference<Thread> threadRef(ThreadRefRef ref) =>
    FirebaseFirestore.instance.collection('thread').withConverter<Thread>(
          fromFirestore: (snapshot, _) => Thread.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
