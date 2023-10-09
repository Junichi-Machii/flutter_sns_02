// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comment _$$_CommentFromJson(Map<String, dynamic> json) => _$_Comment(
      createdAt: json['createdAt'],
      postCommentReplyCount: json['postCommentReplyCount'] as int,
      likeCount: json['likeCount'] as int,
      comment: json['comment'] as String,
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
      uid: json['uid'] as String,
      postCommentId: json['postCommentId'] as String,
    );

Map<String, dynamic> _$$_CommentToJson(_$_Comment instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'postCommentReplyCount': instance.postCommentReplyCount,
      'likeCount': instance.likeCount,
      'comment': instance.comment,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'uid': instance.uid,
      'postCommentId': instance.postCommentId,
    };
