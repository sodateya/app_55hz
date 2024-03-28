import 'package:app_55hz/model/talk/talk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'talk_state.freezed.dart';

@freezed
class TalkState with _$TalkState {
  const factory TalkState({
    @Default([]) List<Talk> talks,
    DocumentSnapshot<Talk>? lastDoc,
  }) = _TalkState;
}
