// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'thread.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Thread _$ThreadFromJson(Map<String, dynamic> json) {
  return _Thread.fromJson(json);
}

/// @nodoc
mixin _$Thread {
  String get title => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  String? get documentID => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ThreadCopyWith<Thread> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThreadCopyWith<$Res> {
  factory $ThreadCopyWith(Thread value, $Res Function(Thread) then) =
      _$ThreadCopyWithImpl<$Res, Thread>;
  @useResult
  $Res call(
      {String title,
      @TimestampConverter() DateTime? createdAt,
      String? documentID});
}

/// @nodoc
class _$ThreadCopyWithImpl<$Res, $Val extends Thread>
    implements $ThreadCopyWith<$Res> {
  _$ThreadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? createdAt = freezed,
    Object? documentID = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      documentID: freezed == documentID
          ? _value.documentID
          : documentID // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ThreadImplCopyWith<$Res> implements $ThreadCopyWith<$Res> {
  factory _$$ThreadImplCopyWith(
          _$ThreadImpl value, $Res Function(_$ThreadImpl) then) =
      __$$ThreadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      @TimestampConverter() DateTime? createdAt,
      String? documentID});
}

/// @nodoc
class __$$ThreadImplCopyWithImpl<$Res>
    extends _$ThreadCopyWithImpl<$Res, _$ThreadImpl>
    implements _$$ThreadImplCopyWith<$Res> {
  __$$ThreadImplCopyWithImpl(
      _$ThreadImpl _value, $Res Function(_$ThreadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? createdAt = freezed,
    Object? documentID = freezed,
  }) {
    return _then(_$ThreadImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      documentID: freezed == documentID
          ? _value.documentID
          : documentID // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ThreadImpl implements _Thread {
  const _$ThreadImpl(
      {required this.title,
      @TimestampConverter() required this.createdAt,
      this.documentID});

  factory _$ThreadImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThreadImplFromJson(json);

  @override
  final String title;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  final String? documentID;

  @override
  String toString() {
    return 'Thread(title: $title, createdAt: $createdAt, documentID: $documentID)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThreadImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.documentID, documentID) ||
                other.documentID == documentID));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, title, createdAt, documentID);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ThreadImplCopyWith<_$ThreadImpl> get copyWith =>
      __$$ThreadImplCopyWithImpl<_$ThreadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThreadImplToJson(
      this,
    );
  }
}

abstract class _Thread implements Thread {
  const factory _Thread(
      {required final String title,
      @TimestampConverter() required final DateTime? createdAt,
      final String? documentID}) = _$ThreadImpl;

  factory _Thread.fromJson(Map<String, dynamic> json) = _$ThreadImpl.fromJson;

  @override
  String get title;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  String? get documentID;
  @override
  @JsonKey(ignore: true)
  _$$ThreadImplCopyWith<_$ThreadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
