// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TalkImpl _$$TalkImplFromJson(Map<String, dynamic> json) => _$TalkImpl(
      uid: json['uid'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      documentID: json['documentID'] as String?,
      comment: json['comment'] as String?,
      count: json['count'] as int?,
      badCount: json['badCount'] as List<dynamic>?,
      good: json['good'] as List<dynamic>?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      imgURL: json['imgURL'] as String?,
    );

Map<String, dynamic> _$$TalkImplToJson(_$TalkImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'documentID': instance.documentID,
      'comment': instance.comment,
      'count': instance.count,
      'badCount': instance.badCount,
      'good': instance.good,
      'url': instance.url,
      'name': instance.name,
      'imgURL': instance.imgURL,
    };
