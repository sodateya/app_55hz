import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/talk/provider/ref/talk_ref_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'good_talk_provider.g.dart';

@riverpod
class GoodTalk extends _$GoodTalk {
  @override
  build() {
    return '';
  }

  Future addGood(String postId, String threadId, String talkId) async {
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    final doc = ref.read(talkRefProvider(postId, threadId)).doc(talkId);
    doc.update({
      'good': FieldValue.arrayUnion([uid])
    });
  }

  Future removeGood(String postId, String threadId, String talkId) async {
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    final doc = ref.read(talkRefProvider(postId, threadId)).doc(talkId);
    doc.update({
      'good': FieldValue.arrayRemove([uid])
    });
  }
}
