import 'package:app_55hz/model/talk/talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'talk_ref_provider.g.dart';

@riverpod
CollectionReference<Talk> talkRef(
    TalkRefRef ref, String postId, String threadId) {
  return FirebaseFirestore.instance
      .collection('thread')
      .doc(threadId)
      .collection('post')
      .doc(postId)
      .collection('talk')
      .withConverter<Talk>(
        fromFirestore: (snapshot, _) => Talk.fromJson(snapshot.data()!),
        toFirestore: (product, _) => product.toJson(),
      );
}
