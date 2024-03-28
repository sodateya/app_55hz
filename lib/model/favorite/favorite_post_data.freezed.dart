// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_post_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavoritePostData _$FavoritePostDataFromJson(Map<String, dynamic> json) {
  return _FavoritePostData.fromJson(json);
}

/// @nodoc
mixin _$FavoritePostData {
  String get title => throw _privateConstructorUsedError;
  String get docID => throw _privateConstructorUsedError;
  String get threadID => throw _privateConstructorUsedError;
  String get threadUid => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavoritePostDataCopyWith<FavoritePostData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritePostDataCopyWith<$Res> {
  factory $FavoritePostDataCopyWith(
          FavoritePostData value, $Res Function(FavoritePostData) then) =
      _$FavoritePostDataCopyWithImpl<$Res, FavoritePostData>;
  @useResult
  $Res call(
      {String title,
      String docID,
      String threadID,
      String threadUid,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$FavoritePostDataCopyWithImpl<$Res, $Val extends FavoritePostData>
    implements $FavoritePostDataCopyWith<$Res> {
  _$FavoritePostDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? docID = null,
    Object? threadID = null,
    Object? threadUid = null,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      docID: null == docID
          ? _value.docID
          : docID // ignore: cast_nullable_to_non_nullable
              as String,
      threadID: null == threadID
          ? _value.threadID
          : threadID // ignore: cast_nullable_to_non_nullable
              as String,
      threadUid: null == threadUid
          ? _value.threadUid
          : threadUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FavoritePostDataImplCopyWith<$Res>
    implements $FavoritePostDataCopyWith<$Res> {
  factory _$$FavoritePostDataImplCopyWith(_$FavoritePostDataImpl value,
          $Res Function(_$FavoritePostDataImpl) then) =
      __$$FavoritePostDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String docID,
      String threadID,
      String threadUid,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$FavoritePostDataImplCopyWithImpl<$Res>
    extends _$FavoritePostDataCopyWithImpl<$Res, _$FavoritePostDataImpl>
    implements _$$FavoritePostDataImplCopyWith<$Res> {
  __$$FavoritePostDataImplCopyWithImpl(_$FavoritePostDataImpl _value,
      $Res Function(_$FavoritePostDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? docID = null,
    Object? threadID = null,
    Object? threadUid = null,
    Object? createdAt = freezed,
  }) {
    return _then(_$FavoritePostDataImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      docID: null == docID
          ? _value.docID
          : docID // ignore: cast_nullable_to_non_nullable
              as String,
      threadID: null == threadID
          ? _value.threadID
          : threadID // ignore: cast_nullable_to_non_nullable
              as String,
      threadUid: null == threadUid
          ? _value.threadUid
          : threadUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FavoritePostDataImpl implements _FavoritePostData {
  const _$FavoritePostDataImpl(
      {required this.title,
      required this.docID,
      required this.threadID,
      required this.threadUid,
      @TimestampConverter() this.createdAt});

  factory _$FavoritePostDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FavoritePostDataImplFromJson(json);

  @override
  final String title;
  @override
  final String docID;
  @override
  final String threadID;
  @override
  final String threadUid;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'FavoritePostData(title: $title, docID: $docID, threadID: $threadID, threadUid: $threadUid, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritePostDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.docID, docID) || other.docID == docID) &&
            (identical(other.threadID, threadID) ||
                other.threadID == threadID) &&
            (identical(other.threadUid, threadUid) ||
                other.threadUid == threadUid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, docID, threadID, threadUid, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritePostDataImplCopyWith<_$FavoritePostDataImpl> get copyWith =>
      __$$FavoritePostDataImplCopyWithImpl<_$FavoritePostDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FavoritePostDataImplToJson(
      this,
    );
  }
}

abstract class _FavoritePostData implements FavoritePostData {
  const factory _FavoritePostData(
          {required final String title,
          required final String docID,
          required final String threadID,
          required final String threadUid,
          @TimestampConverter() final DateTime? createdAt}) =
      _$FavoritePostDataImpl;

  factory _FavoritePostData.fromJson(Map<String, dynamic> json) =
      _$FavoritePostDataImpl.fromJson;

  @override
  String get title;
  @override
  String get docID;
  @override
  String get threadID;
  @override
  String get threadUid;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$FavoritePostDataImplCopyWith<_$FavoritePostDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
