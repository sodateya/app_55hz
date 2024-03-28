import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bad_post_provider.g.dart';

@riverpod
class BadPost extends _$BadPost {
  @override
  build() {
    return '';
  }

  Future addBadPost(String threadId, String postId, String uid) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(threadId)
        .collection('post')
        .doc(postId)
        .update({
      'badCount': FieldValue.arrayUnion([uid])
    });
  }

//とりあえず使わない
  Future removeBadPost(String threadId, String postId, String uid) async {
    await FirebaseFirestore.instance
        .collection('thread')
        .doc(threadId)
        .collection('post')
        .doc(postId)
        .update({
      'badCount': FieldValue.arrayRemove([uid])
    });
  }
}
