// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_9ch.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User9ch _$User9chFromJson(Map<String, dynamic> json) {
  return _User9ch.fromJson(json);
}

/// @nodoc
mixin _$User9ch {
  String get pushToken => throw _privateConstructorUsedError;
  String get udid => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get uid20 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $User9chCopyWith<User9ch> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $User9chCopyWith<$Res> {
  factory $User9chCopyWith(User9ch value, $Res Function(User9ch) then) =
      _$User9chCopyWithImpl<$Res, User9ch>;
  @useResult
  $Res call({String pushToken, String udid, String uid, String uid20});
}

/// @nodoc
class _$User9chCopyWithImpl<$Res, $Val extends User9ch>
    implements $User9chCopyWith<$Res> {
  _$User9chCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushToken = null,
    Object? udid = null,
    Object? uid = null,
    Object? uid20 = null,
  }) {
    return _then(_value.copyWith(
      pushToken: null == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String,
      udid: null == udid
          ? _value.udid
          : udid // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      uid20: null == uid20
          ? _value.uid20
          : uid20 // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$User9chImplCopyWith<$Res> implements $User9chCopyWith<$Res> {
  factory _$$User9chImplCopyWith(
          _$User9chImpl value, $Res Function(_$User9chImpl) then) =
      __$$User9chImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String pushToken, String udid, String uid, String uid20});
}

/// @nodoc
class __$$User9chImplCopyWithImpl<$Res>
    extends _$User9chCopyWithImpl<$Res, _$User9chImpl>
    implements _$$User9chImplCopyWith<$Res> {
  __$$User9chImplCopyWithImpl(
      _$User9chImpl _value, $Res Function(_$User9chImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushToken = null,
    Object? udid = null,
    Object? uid = null,
    Object? uid20 = null,
  }) {
    return _then(_$User9chImpl(
      pushToken: null == pushToken
          ? _value.pushToken
          : pushToken // ignore: cast_nullable_to_non_nullable
              as String,
      udid: null == udid
          ? _value.udid
          : udid // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      uid20: null == uid20
          ? _value.uid20
          : uid20 // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$User9chImpl implements _User9ch {
  const _$User9chImpl(
      {required this.pushToken,
      required this.udid,
      required this.uid,
      required this.uid20});

  factory _$User9chImpl.fromJson(Map<String, dynamic> json) =>
      _$$User9chImplFromJson(json);

  @override
  final String pushToken;
  @override
  final String udid;
  @override
  final String uid;
  @override
  final String uid20;

  @override
  String toString() {
    return 'User9ch(pushToken: $pushToken, udid: $udid, uid: $uid, uid20: $uid20)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$User9chImpl &&
            (identical(other.pushToken, pushToken) ||
                other.pushToken == pushToken) &&
            (identical(other.udid, udid) || other.udid == udid) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.uid20, uid20) || other.uid20 == uid20));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pushToken, udid, uid, uid20);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$User9chImplCopyWith<_$User9chImpl> get copyWith =>
      __$$User9chImplCopyWithImpl<_$User9chImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$User9chImplToJson(
      this,
    );
  }
}

abstract class _User9ch implements User9ch {
  const factory _User9ch(
      {required final String pushToken,
      required final String udid,
      required final String uid,
      required final String uid20}) = _$User9chImpl;

  factory _User9ch.fromJson(Map<String, dynamic> json) = _$User9chImpl.fromJson;

  @override
  String get pushToken;
  @override
  String get udid;
  @override
  String get uid;
  @override
  String get uid20;
  @override
  @JsonKey(ignore: true)
  _$$User9chImplCopyWith<_$User9chImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
