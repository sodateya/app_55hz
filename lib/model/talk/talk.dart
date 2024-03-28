import 'package:app_55hz/converter/timestam_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'talk.freezed.dart';
part 'talk.g.dart';

@freezed
class Talk with _$Talk {
  const factory Talk({
    String? uid,
    @TimestampConverter() DateTime? createdAt,
    String? documentID,
    String? comment,
    int? count,
    List? badCount,
    List? good,
    String? url,
    String? name,
    String? imgURL,
  }) = _Talk;
  factory Talk.fromJson(Map<String, dynamic> json) => _$TalkFromJson(json);
}
