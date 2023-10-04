// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_post_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LikePostToken _$$_LikePostTokenFromJson(Map<String, dynamic> json) =>
    _$_LikePostToken(
      createdAt: json['createdAt'],
      activeUid: json['activeUid'] as String,
      passiveUid: json['passiveUid'] as String,
      postRef: json['postRef'],
      postId: json['postId'] as String,
      tokenId: json['tokenId'] as String,
      tokenType: json['tokenType'] as String,
    );

Map<String, dynamic> _$$_LikePostTokenToJson(_$_LikePostToken instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'activeUid': instance.activeUid,
      'passiveUid': instance.passiveUid,
      'postRef': instance.postRef,
      'postId': instance.postId,
      'tokenId': instance.tokenId,
      'tokenType': instance.tokenType,
    };
