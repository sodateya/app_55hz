import 'package:app_55hz/converter/timestam_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_post_data.freezed.dart';
part 'favorite_post_data.g.dart';

@freezed
class FavoritePostData with _$FavoritePostData {
  const factory FavoritePostData({
    required String title,
    required String docID,
    required String threadID,
    required String threadUid,
    @TimestampConverter() DateTime? createdAt,
  }) = _FavoritePostData;
  factory FavoritePostData.fromJson(Map<String, dynamic> json) =>
      _$FavoritePostDataFromJson(json);
}
