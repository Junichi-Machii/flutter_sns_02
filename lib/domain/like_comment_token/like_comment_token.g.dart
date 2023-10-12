// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_comment_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LikeCommentToken _$$_LikeCommentTokenFromJson(Map<String, dynamic> json) =>
    _$_LikeCommentToken(
      createdAt: json['createdAt'],
      activeUid: json['activeUid'] as String,
      passiveUid: json['passiveUid'] as String,
      commentRef: json['commentRef'],
      postCommentId: json['postCommentId'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$_LikeCommentTokenToJson(_$_LikeCommentToken instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'activeUid': instance.activeUid,
      'passiveUid': instance.passiveUid,
      'commentRef': instance.commentRef,
      'postCommentId': instance.postCommentId,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
