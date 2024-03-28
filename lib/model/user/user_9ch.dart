import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_9ch.freezed.dart';
part 'user_9ch.g.dart';

@freezed
class User9ch with _$User9ch {
  const factory User9ch({
    required String pushToken,
    required String udid,
    required String uid,
    required String uid20,
    //@Default(false) bool isPremium,
  }) = _User9ch;
  factory User9ch.fromJson(Map<String, dynamic> json) =>
      _$User9chFromJson(json);
}
