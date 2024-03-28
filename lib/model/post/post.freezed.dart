// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  String? get title => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get upDateAt => throw _privateConstructorUsedError;
  String? get documentID => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  List<dynamic>? get badCount => throw _privateConstructorUsedError;
  List<dynamic>? get read => throw _privateConstructorUsedError;
  List<dynamic>? get accessBlock => throw _privateConstructorUsedError;
  String? get threadId => throw _privateConstructorUsedError;
  int? get postCount => throw _privateConstructorUsedError;
  String? get mainToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
  @useResult
  $Res call(
      {String? title,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? upDateAt,
      String? documentID,
      String? uid,
      List<dynamic>? badCount,
      List<dynamic>? read,
      List<dynamic>? accessBlock,
      String? threadId,
      int? postCount,
      String? mainToken});
}

/// @nodoc
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? upDateAt = freezed,
    Object? documentID = freezed,
    Object? uid = freezed,
    Object? badCount = freezed,
    Object? read = freezed,
    Object? accessBlock = freezed,
    Object? threadId = freezed,
    Object? postCount = freezed,
    Object? mainToken = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      upDateAt: freezed == upDateAt
          ? _value.upDateAt
          : upDateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      documentID: freezed == documentID
          ? _value.documentID
          : documentID // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      badCount: freezed == badCount
          ? _value.badCount
          : badCount // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      read: freezed == read
          ? _value.read
          : read // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      accessBlock: freezed == accessBlock
          ? _value.accessBlock
          : accessBlock // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      threadId: freezed == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String?,
      postCount: freezed == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int?,
      mainToken: freezed == mainToken
          ? _value.mainToken
          : mainToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? upDateAt,
      String? documentID,
      String? uid,
      List<dynamic>? badCount,
      List<dynamic>? read,
      List<dynamic>? accessBlock,
      String? threadId,
      int? postCount,
      String? mainToken});
}

/// @nodoc
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? createdAt = freezed,
    Object? upDateAt = freezed,
    Object? documentID = freezed,
    Object? uid = freezed,
    Object? badCount = freezed,
    Object? read = freezed,
    Object? accessBlock = freezed,
    Object? threadId = freezed,
    Object? postCount = freezed,
    Object? mainToken = freezed,
  }) {
    return _then(_$PostImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      upDateAt: freezed == upDateAt
          ? _value.upDateAt
          : upDateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      documentID: freezed == documentID
          ? _value.documentID
          : documentID // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      badCount: freezed == badCount
          ? _value._badCount
          : badCount // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      read: freezed == read
          ? _value._read
          : read // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      accessBlock: freezed == accessBlock
          ? _value._accessBlock
          : accessBlock // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      threadId: freezed == threadId
          ? _value.threadId
          : threadId // ignore: cast_nullable_to_non_nullable
              as String?,
      postCount: freezed == postCount
          ? _value.postCount
          : postCount // ignore: cast_nullable_to_non_nullable
              as int?,
      mainToken: freezed == mainToken
          ? _value.mainToken
          : mainToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostImpl implements _Post {
  const _$PostImpl(
      {this.title,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.upDateAt,
      this.documentID,
      this.uid,
      final List<dynamic>? badCount,
      final List<dynamic>? read,
      final List<dynamic>? accessBlock,
      this.threadId,
      this.postCount,
      this.mainToken})
      : _badCount = badCount,
        _read = read,
        _accessBlock = accessBlock;

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  @override
  final String? title;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? upDateAt;
  @override
  final String? documentID;
  @override
  final String? uid;
  final List<dynamic>? _badCount;
  @override
  List<dynamic>? get badCount {
    final value = _badCount;
    if (value == null) return null;
    if (_badCount is EqualUnmodifiableListView) return _badCount;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _read;
  @override
  List<dynamic>? get read {
    final value = _read;
    if (value == null) return null;
    if (_read is EqualUnmodifiableListView) return _read;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<dynamic>? _accessBlock;
  @override
  List<dynamic>? get accessBlock {
    final value = _accessBlock;
    if (value == null) return null;
    if (_accessBlock is EqualUnmodifiableListView) return _accessBlock;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? threadId;
  @override
  final int? postCount;
  @override
  final String? mainToken;

  @override
  String toString() {
    return 'Post(title: $title, createdAt: $createdAt, upDateAt: $upDateAt, documentID: $documentID, uid: $uid, badCount: $badCount, read: $read, accessBlock: $accessBlock, threadId: $threadId, postCount: $postCount, mainToken: $mainToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.upDateAt, upDateAt) ||
                other.upDateAt == upDateAt) &&
            (identical(other.documentID, documentID) ||
                other.documentID == documentID) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality().equals(other._badCount, _badCount) &&
            const DeepCollectionEquality().equals(other._read, _read) &&
            const DeepCollectionEquality()
                .equals(other._accessBlock, _accessBlock) &&
            (identical(other.threadId, threadId) ||
                other.threadId == threadId) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.mainToken, mainToken) ||
                other.mainToken == mainToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      createdAt,
      upDateAt,
      documentID,
      uid,
      const DeepCollectionEquality().hash(_badCount),
      const DeepCollectionEquality().hash(_read),
      const DeepCollectionEquality().hash(_accessBlock),
      threadId,
      postCount,
      mainToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
      {final String? title,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? upDateAt,
      final String? documentID,
      final String? uid,
      final List<dynamic>? badCount,
      final List<dynamic>? read,
      final List<dynamic>? accessBlock,
      final String? threadId,
      final int? postCount,
      final String? mainToken}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  @override
  String? get title;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get upDateAt;
  @override
  String? get documentID;
  @override
  String? get uid;
  @override
  List<dynamic>? get badCount;
  @override
  List<dynamic>? get read;
  @override
  List<dynamic>? get accessBlock;
  @override
  String? get threadId;
  @override
  int? get postCount;
  @override
  String? get mainToken;
  @override
  @JsonKey(ignore: true)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
