// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_post_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FavoritePostDataImpl _$$FavoritePostDataImplFromJson(
        Map<String, dynamic> json) =>
    _$FavoritePostDataImpl(
      title: json['title'] as String,
      docID: json['docID'] as String,
      threadID: json['threadID'] as String,
      threadUid: json['threadUid'] as String,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$FavoritePostDataImplToJson(
        _$FavoritePostDataImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'docID': instance.docID,
      'threadID': instance.threadID,
      'threadUid': instance.threadUid,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
