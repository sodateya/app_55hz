import 'package:app_55hz/model/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_post_ref.g.dart';

@riverpod
Query<Post> allPostRef(AllPostRefRef ref) =>
    FirebaseFirestore.instance.collectionGroup('post').withConverter<Post>(
          fromFirestore: (snapshot, _) => Post.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson(),
        );
