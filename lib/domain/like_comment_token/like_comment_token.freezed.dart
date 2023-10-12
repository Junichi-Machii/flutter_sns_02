// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'like_comment_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LikeCommentToken _$LikeCommentTokenFromJson(Map<String, dynamic> json) {
  return _LikeCommentToken.fromJson(json);
}

/// @nodoc
mixin _$LikeCommentToken {
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get activeUid => throw _privateConstructorUsedError;
  String get passiveUid => throw _privateConstructorUsedError;
  dynamic get commentRef => throw _privateConstructorUsedError;
  String get commentId => throw _privateConstructorUsedError;
  String get tokenId => throw _privateConstructorUsedError;
  String get tokenType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LikeCommentTokenCopyWith<LikeCommentToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LikeCommentTokenCopyWith<$Res> {
  factory $LikeCommentTokenCopyWith(
          LikeCommentToken value, $Res Function(LikeCommentToken) then) =
      _$LikeCommentTokenCopyWithImpl<$Res, LikeCommentToken>;
  @useResult
  $Res call(
      {dynamic createdAt,
      String activeUid,
      String passiveUid,
      dynamic commentRef,
      String commentId,
      String tokenId,
      String tokenType});
}

/// @nodoc
class _$LikeCommentTokenCopyWithImpl<$Res, $Val extends LikeCommentToken>
    implements $LikeCommentTokenCopyWith<$Res> {
  _$LikeCommentTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? activeUid = null,
    Object? passiveUid = null,
    Object? commentRef = freezed,
    Object? commentId = null,
    Object? tokenId = null,
    Object? tokenType = null,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      passiveUid: null == passiveUid
          ? _value.passiveUid
          : passiveUid // ignore: cast_nullable_to_non_nullable
              as String,
      commentRef: freezed == commentRef
          ? _value.commentRef
          : commentRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      commentId: null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LikeCommentTokenCopyWith<$Res>
    implements $LikeCommentTokenCopyWith<$Res> {
  factory _$$_LikeCommentTokenCopyWith(
          _$_LikeCommentToken value, $Res Function(_$_LikeCommentToken) then) =
      __$$_LikeCommentTokenCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic createdAt,
      String activeUid,
      String passiveUid,
      dynamic commentRef,
      String commentId,
      String tokenId,
      String tokenType});
}

/// @nodoc
class __$$_LikeCommentTokenCopyWithImpl<$Res>
    extends _$LikeCommentTokenCopyWithImpl<$Res, _$_LikeCommentToken>
    implements _$$_LikeCommentTokenCopyWith<$Res> {
  __$$_LikeCommentTokenCopyWithImpl(
      _$_LikeCommentToken _value, $Res Function(_$_LikeCommentToken) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? activeUid = null,
    Object? passiveUid = null,
    Object? commentRef = freezed,
    Object? commentId = null,
    Object? tokenId = null,
    Object? tokenType = null,
  }) {
    return _then(_$_LikeCommentToken(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      activeUid: null == activeUid
          ? _value.activeUid
          : activeUid // ignore: cast_nullable_to_non_nullable
              as String,
      passiveUid: null == passiveUid
          ? _value.passiveUid
          : passiveUid // ignore: cast_nullable_to_non_nullable
              as String,
      commentRef: freezed == commentRef
          ? _value.commentRef
          : commentRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      commentId: null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenId: null == tokenId
          ? _value.tokenId
          : tokenId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenType: null == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LikeCommentToken implements _LikeCommentToken {
  const _$_LikeCommentToken(
      {required this.createdAt,
      required this.activeUid,
      required this.passiveUid,
      required this.commentRef,
      required this.commentId,
      required this.tokenId,
      required this.tokenType});

  factory _$_LikeCommentToken.fromJson(Map<String, dynamic> json) =>
      _$$_LikeCommentTokenFromJson(json);

  @override
  final dynamic createdAt;
  @override
  final String activeUid;
  @override
  final String passiveUid;
  @override
  final dynamic commentRef;
  @override
  final String commentId;
  @override
  final String tokenId;
  @override
  final String tokenType;

  @override
  String toString() {
    return 'LikeCommentToken(createdAt: $createdAt, activeUid: $activeUid, passiveUid: $passiveUid, commentRef: $commentRef, commentId: $commentId, tokenId: $tokenId, tokenType: $tokenType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LikeCommentToken &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.activeUid, activeUid) ||
                other.activeUid == activeUid) &&
            (identical(other.passiveUid, passiveUid) ||
                other.passiveUid == passiveUid) &&
            const DeepCollectionEquality()
                .equals(other.commentRef, commentRef) &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.tokenId, tokenId) || other.tokenId == tokenId) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      activeUid,
      passiveUid,
      const DeepCollectionEquality().hash(commentRef),
      commentId,
      tokenId,
      tokenType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LikeCommentTokenCopyWith<_$_LikeCommentToken> get copyWith =>
      __$$_LikeCommentTokenCopyWithImpl<_$_LikeCommentToken>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LikeCommentTokenToJson(
      this,
    );
  }
}

abstract class _LikeCommentToken implements LikeCommentToken {
  const factory _LikeCommentToken(
      {required final dynamic createdAt,
      required final String activeUid,
      required final String passiveUid,
      required final dynamic commentRef,
      required final String commentId,
      required final String tokenId,
      required final String tokenType}) = _$_LikeCommentToken;

  factory _LikeCommentToken.fromJson(Map<String, dynamic> json) =
      _$_LikeCommentToken.fromJson;

  @override
  dynamic get createdAt;
  @override
  String get activeUid;
  @override
  String get passiveUid;
  @override
  dynamic get commentRef;
  @override
  String get commentId;
  @override
  String get tokenId;
  @override
  String get tokenType;
  @override
  @JsonKey(ignore: true)
  _$$_LikeCommentTokenCopyWith<_$_LikeCommentToken> get copyWith =>
      throw _privateConstructorUsedError;
}
