// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'talk_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TalkState {
  List<Talk> get talks => throw _privateConstructorUsedError;
  DocumentSnapshot<Talk>? get lastDoc => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TalkStateCopyWith<TalkState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TalkStateCopyWith<$Res> {
  factory $TalkStateCopyWith(TalkState value, $Res Function(TalkState) then) =
      _$TalkStateCopyWithImpl<$Res, TalkState>;
  @useResult
  $Res call({List<Talk> talks, DocumentSnapshot<Talk>? lastDoc});
}

/// @nodoc
class _$TalkStateCopyWithImpl<$Res, $Val extends TalkState>
    implements $TalkStateCopyWith<$Res> {
  _$TalkStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? talks = null,
    Object? lastDoc = freezed,
  }) {
    return _then(_value.copyWith(
      talks: null == talks
          ? _value.talks
          : talks // ignore: cast_nullable_to_non_nullable
              as List<Talk>,
      lastDoc: freezed == lastDoc
          ? _value.lastDoc
          : lastDoc // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Talk>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TalkStateImplCopyWith<$Res>
    implements $TalkStateCopyWith<$Res> {
  factory _$$TalkStateImplCopyWith(
          _$TalkStateImpl value, $Res Function(_$TalkStateImpl) then) =
      __$$TalkStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Talk> talks, DocumentSnapshot<Talk>? lastDoc});
}

/// @nodoc
class __$$TalkStateImplCopyWithImpl<$Res>
    extends _$TalkStateCopyWithImpl<$Res, _$TalkStateImpl>
    implements _$$TalkStateImplCopyWith<$Res> {
  __$$TalkStateImplCopyWithImpl(
      _$TalkStateImpl _value, $Res Function(_$TalkStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? talks = null,
    Object? lastDoc = freezed,
  }) {
    return _then(_$TalkStateImpl(
      talks: null == talks
          ? _value._talks
          : talks // ignore: cast_nullable_to_non_nullable
              as List<Talk>,
      lastDoc: freezed == lastDoc
          ? _value.lastDoc
          : lastDoc // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Talk>?,
    ));
  }
}

/// @nodoc

class _$TalkStateImpl implements _TalkState {
  const _$TalkStateImpl({final List<Talk> talks = const [], this.lastDoc})
      : _talks = talks;

  final List<Talk> _talks;
  @override
  @JsonKey()
  List<Talk> get talks {
    if (_talks is EqualUnmodifiableListView) return _talks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_talks);
  }

  @override
  final DocumentSnapshot<Talk>? lastDoc;

  @override
  String toString() {
    return 'TalkState(talks: $talks, lastDoc: $lastDoc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TalkStateImpl &&
            const DeepCollectionEquality().equals(other._talks, _talks) &&
            (identical(other.lastDoc, lastDoc) || other.lastDoc == lastDoc));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_talks), lastDoc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TalkStateImplCopyWith<_$TalkStateImpl> get copyWith =>
      __$$TalkStateImplCopyWithImpl<_$TalkStateImpl>(this, _$identity);
}

abstract class _TalkState implements TalkState {
  const factory _TalkState(
      {final List<Talk> talks,
      final DocumentSnapshot<Talk>? lastDoc}) = _$TalkStateImpl;

  @override
  List<Talk> get talks;
  @override
  DocumentSnapshot<Talk>? get lastDoc;
  @override
  @JsonKey(ignore: true)
  _$$TalkStateImplCopyWith<_$TalkStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
