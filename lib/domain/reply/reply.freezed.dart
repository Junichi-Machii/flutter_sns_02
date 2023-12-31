// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Reply _$ReplyFromJson(Map<String, dynamic> json) {
  return _Reply.fromJson(json);
}

/// @nodoc
mixin _$Reply {
  dynamic get createdAt => throw _privateConstructorUsedError;
  String get reply => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  dynamic get postRef => throw _privateConstructorUsedError;
  dynamic get postCommentRef => throw _privateConstructorUsedError;
  String get postCommentReplyId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get userImageURL => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReplyCopyWith<Reply> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyCopyWith<$Res> {
  factory $ReplyCopyWith(Reply value, $Res Function(Reply) then) =
      _$ReplyCopyWithImpl<$Res, Reply>;
  @useResult
  $Res call(
      {dynamic createdAt,
      String reply,
      int likeCount,
      dynamic postRef,
      dynamic postCommentRef,
      String postCommentReplyId,
      String userName,
      String uid,
      String userImageURL});
}

/// @nodoc
class _$ReplyCopyWithImpl<$Res, $Val extends Reply>
    implements $ReplyCopyWith<$Res> {
  _$ReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? reply = null,
    Object? likeCount = null,
    Object? postRef = freezed,
    Object? postCommentRef = freezed,
    Object? postCommentReplyId = null,
    Object? userName = null,
    Object? uid = null,
    Object? userImageURL = null,
  }) {
    return _then(_value.copyWith(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      reply: null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      postRef: freezed == postRef
          ? _value.postRef
          : postRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCommentRef: freezed == postCommentRef
          ? _value.postCommentRef
          : postCommentRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCommentReplyId: null == postCommentReplyId
          ? _value.postCommentReplyId
          : postCommentReplyId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReplyCopyWith<$Res> implements $ReplyCopyWith<$Res> {
  factory _$$_ReplyCopyWith(_$_Reply value, $Res Function(_$_Reply) then) =
      __$$_ReplyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {dynamic createdAt,
      String reply,
      int likeCount,
      dynamic postRef,
      dynamic postCommentRef,
      String postCommentReplyId,
      String userName,
      String uid,
      String userImageURL});
}

/// @nodoc
class __$$_ReplyCopyWithImpl<$Res> extends _$ReplyCopyWithImpl<$Res, _$_Reply>
    implements _$$_ReplyCopyWith<$Res> {
  __$$_ReplyCopyWithImpl(_$_Reply _value, $Res Function(_$_Reply) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? createdAt = freezed,
    Object? reply = null,
    Object? likeCount = null,
    Object? postRef = freezed,
    Object? postCommentRef = freezed,
    Object? postCommentReplyId = null,
    Object? userName = null,
    Object? uid = null,
    Object? userImageURL = null,
  }) {
    return _then(_$_Reply(
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as dynamic,
      reply: null == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      postRef: freezed == postRef
          ? _value.postRef
          : postRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCommentRef: freezed == postCommentRef
          ? _value.postCommentRef
          : postCommentRef // ignore: cast_nullable_to_non_nullable
              as dynamic,
      postCommentReplyId: null == postCommentReplyId
          ? _value.postCommentReplyId
          : postCommentReplyId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      userImageURL: null == userImageURL
          ? _value.userImageURL
          : userImageURL // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Reply implements _Reply {
  const _$_Reply(
      {required this.createdAt,
      required this.reply,
      required this.likeCount,
      required this.postRef,
      required this.postCommentRef,
      required this.postCommentReplyId,
      required this.userName,
      required this.uid,
      required this.userImageURL});

  factory _$_Reply.fromJson(Map<String, dynamic> json) =>
      _$$_ReplyFromJson(json);

  @override
  final dynamic createdAt;
  @override
  final String reply;
  @override
  final int likeCount;
  @override
  final dynamic postRef;
  @override
  final dynamic postCommentRef;
  @override
  final String postCommentReplyId;
  @override
  final String userName;
  @override
  final String uid;
  @override
  final String userImageURL;

  @override
  String toString() {
    return 'Reply(createdAt: $createdAt, reply: $reply, likeCount: $likeCount, postRef: $postRef, postCommentRef: $postCommentRef, postCommentReplyId: $postCommentReplyId, userName: $userName, uid: $uid, userImageURL: $userImageURL)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Reply &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            (identical(other.reply, reply) || other.reply == reply) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            const DeepCollectionEquality().equals(other.postRef, postRef) &&
            const DeepCollectionEquality()
                .equals(other.postCommentRef, postCommentRef) &&
            (identical(other.postCommentReplyId, postCommentReplyId) ||
                other.postCommentReplyId == postCommentReplyId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.userImageURL, userImageURL) ||
                other.userImageURL == userImageURL));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(createdAt),
      reply,
      likeCount,
      const DeepCollectionEquality().hash(postRef),
      const DeepCollectionEquality().hash(postCommentRef),
      postCommentReplyId,
      userName,
      uid,
      userImageURL);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReplyCopyWith<_$_Reply> get copyWith =>
      __$$_ReplyCopyWithImpl<_$_Reply>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReplyToJson(
      this,
    );
  }
}

abstract class _Reply implements Reply {
  const factory _Reply(
      {required final dynamic createdAt,
      required final String reply,
      required final int likeCount,
      required final dynamic postRef,
      required final dynamic postCommentRef,
      required final String postCommentReplyId,
      required final String userName,
      required final String uid,
      required final String userImageURL}) = _$_Reply;

  factory _Reply.fromJson(Map<String, dynamic> json) = _$_Reply.fromJson;

  @override
  dynamic get createdAt;
  @override
  String get reply;
  @override
  int get likeCount;
  @override
  dynamic get postRef;
  @override
  dynamic get postCommentRef;
  @override
  String get postCommentReplyId;
  @override
  String get userName;
  @override
  String get uid;
  @override
  String get userImageURL;
  @override
  @JsonKey(ignore: true)
  _$$_ReplyCopyWith<_$_Reply> get copyWith =>
      throw _privateConstructorUsedError;
}
