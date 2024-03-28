import 'package:app_55hz/model/favorite/favorite_post_data.dart';
import 'package:app_55hz/model/post/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_state.freezed.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState({
    @Default([]) List<Post> posts,
    DocumentSnapshot<FavoritePostData>? lastDoc,
  }) = _FavoriteState;
}
