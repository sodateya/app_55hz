import 'package:app_55hz/%20presentation/favorite/provider/favorite_page_provider/favorite_ref_provider.dart';
import 'package:app_55hz/%20presentation/favorite/provider/favorite_ref_provider.dart';
import 'package:app_55hz/%20presentation/login/provider/auth/firebase_auth/firebase_auth_provider.dart';
import 'package:app_55hz/%20presentation/top/provider/ref/post_ref_provider.dart';
import 'package:app_55hz/model/favorite/favorite_post_data.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favo_method_provider.g.dart';

@riverpod
class FavoMethod extends _$FavoMethod {
  @override
  build() {
    return '';
  }

  void changeFavo(String postId, String title, String threadId,
      String threadUid, bool isFavorite) {
    if (isFavorite) {
      ref.read(favoriteRefProvider).update({
        'favoriteThreads': FieldValue.arrayRemove([postId.substring(10)])
      });
      ref.read(favoritePostDataRefProvider).doc(postId).delete();
    } else {
      ref.read(favoriteRefProvider).update({
        'favoriteThreads': FieldValue.arrayUnion([postId.substring(10)])
      });
      // Firestoreから取得したデータ
      final timestampFromFirestore = Timestamp.now();
      // TimestampをDateTimeに変換
      final dateTime = timestampFromFirestore.toDate();
      final data = FavoritePostData(
          createdAt: dateTime,
          title: title,
          docID: postId,
          threadID: threadId,
          threadUid: threadUid);
      ref.read(favoritePostDataRefProvider).doc(postId).set(data);
    }
  }

  Future readPost(Post post) async {
    final uid = ref.read(firebaseAuthInstanceProvider).currentUser!.uid;
    await ref
        .watch(postRefProvider(post.threadId!))
        .doc(post.documentID)
        .update({
      'read': FieldValue.arrayUnion([uid.substring(20)])
    });
  }
}
