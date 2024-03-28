// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      title: json['title'] as String?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      upDateAt:
          const TimestampConverter().fromJson(json['upDateAt'] as Timestamp?),
      documentID: json['documentID'] as String?,
      uid: json['uid'] as String?,
      badCount: json['badCount'] as List<dynamic>?,
      read: json['read'] as List<dynamic>?,
      accessBlock: json['accessBlock'] as List<dynamic>?,
      threadId: json['threadId'] as String?,
      postCount: json['postCount'] as int?,
      mainToken: json['mainToken'] as String?,
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'upDateAt': const TimestampConverter().toJson(instance.upDateAt),
      'documentID': instance.documentID,
      'uid': instance.uid,
      'badCount': instance.badCount,
      'read': instance.read,
      'accessBlock': instance.accessBlock,
      'threadId': instance.threadId,
      'postCount': instance.postCount,
      'mainToken': instance.mainToken,
    };
