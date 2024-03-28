import 'package:app_55hz/model/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'post_ref_provider.g.dart';

@riverpod
CollectionReference<Post> postRef(PostRefRef ref, String id) =>
    FirebaseFirestore.instance
        .collection('thread')
        .doc(id)
        .collection('post')
        .withConverter<Post>(
          fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
