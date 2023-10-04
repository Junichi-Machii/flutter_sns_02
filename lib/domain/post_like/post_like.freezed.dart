// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_like.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostLike _$PostLikeFromJson(Map<String, dynamic> json) {
  return _PostLike.fromJson(json);
}

/// @nodoc
mixin _$PostLike {
  String get activeUid => throw _privateConstructorUsedError;
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get postCreatorUid => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  dynamic get postRef => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostLikeCopyWith<PostLike> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostLikeCopyWith<$Res> {
  factory $PostLikeCopyWith(PostLike value, $Res Function(PostLike) then) =
      _$PostLikeCopyWithImpl<$Res, PostLike>;
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postCreatorUid,
      String postId,
      dynamic postRef});
}

/// @nodoc
class _$PostLikeCopyWithImpl<$Res, $Val extends PostLike>
    implements $PostLikeCopyWith<$Res> {
  _$PostLikeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? postCreatorUid = null,
    Object? postId = null,
    Object? postRef = freezed,
  }) {
    return _then(_value.copyWith(
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCreatorUid: null == postCreatorUid
          ? _value.postCreatorUid
          : postCreatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postRef: freezed == postRef
          ? _value.postRef
          : postRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostLikeCopyWith<$Res> implements $PostLikeCopyWith<$Res> {
  factory _$$_PostLikeCopyWith(
          _$_PostLike value, $Res Function(_$_PostLike) then) =
      __$$_PostLikeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String activeUid,
      dynamic createdAt,
      String postCreatorUid,
      String postId,
      dynamic postRef});
}

/// @nodoc
class __$$_PostLikeCopyWithImpl<$Res>
    extends _$PostLikeCopyWithImpl<$Res, _$_PostLike>
    implements _$$_PostLikeCopyWith<$Res> {
  __$$_PostLikeCopyWithImpl(
      _$_PostLike _value, $Res Function(_$_PostLike) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeUid = null,
    Object? createdAt = freezed,
    Object? postCreatorUid = null,
    Object? postId = null,
    Object? postRef = freezed,
  }) {
    return _then(_$_PostLike(
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCreatorUid: null == postCreatorUid
          ? _value.postCreatorUid
          : postCreatorUid // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postRef: freezed == postRef
          ? _value.postRef
          : postRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostLike implements _PostLike {
  const _$_PostLike(
      {required this.activeUid,
      required this.createdAt,
      required this.postCreatorUid,
      required this.postId,
      required this.postRef});

  factory _$_PostLike.fromJson(Map<String, dynamic> json) =>
      _$$_PostLikeFromJson(json);

  @override
  final String activeUid;
  @override
  final dynamic createdAt;
  @override
  final String postCreatorUid;
  @override
  final String postId;
  @override
  final dynamic postRef;

  @override
  String toString() {
    return 'PostLike(activeUid: $activeUid, createdAt: $createdAt, postCreatorUid: $postCreatorUid, postId: $postId, postRef: $postRef)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostLike &&
            (identical(other.activeUid, activeUid) ||
                other.activeUid == activeUid) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.postCreatorUid, postCreatorUid) ||
                other.postCreatorUid == postCreatorUid) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            const DeepCollectionEquality().equals(other.postRef, postRef));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      activeUid,
      const DeepCollectionEquality().hash(createdAt),
      postCreatorUid,
      postId,
      const DeepCollectionEquality().hash(postRef));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostLikeCopyWith<_$_PostLike> get copyWith =>
      __$$_PostLikeCopyWithImpl<_$_PostLike>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostLikeToJson(
      this,
    );
  }
}

abstract class _PostLike implements PostLike {
  const factory _PostLike(
      {required final String activeUid,
      required final dynamic createdAt,
      required final String postCreatorUid,
      required final String postId,
      required final dynamic postRef}) = _$_PostLike;

  factory _PostLike.fromJson(Map<String, dynamic> json) = _$_PostLike.fromJson;

  @override
  String get activeUid;
  @override
  dynamic get createdAt;
  @override
  String get postCreatorUid;
  @override
  String get postId;
  @override
  dynamic get postRef;
  @override
  @JsonKey(ignore: true)
  _$$_PostLikeCopyWith<_$_PostLike> get copyWith =>
      throw _privateConstructorUsedError;
}
