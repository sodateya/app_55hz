import 'package:app_55hz/converter/timestam_converter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'thread.freezed.dart';
part 'thread.g.dart';

@freezed
class Thread with _$Thread {
  const factory Thread({
    required String title,
    @TimestampConverter() required DateTime? createdAt,
    String? documentID,
  }) = _Thread;
  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);
}
