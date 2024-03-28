import 'package:app_55hz/converter/timestam_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    String? title,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? upDateAt,
    String? documentID,
    String? uid,
    List? badCount,
    List? read,
    List? accessBlock,
    String? threadId,
    int? postCount,
    String? mainToken,
    //required int id,
//@Default(false) bool isPremium,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
