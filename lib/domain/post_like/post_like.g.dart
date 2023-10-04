// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostLike _$$_PostLikeFromJson(Map<String, dynamic> json) => _$_PostLike(
      activeUid: json['activeUid'] as String,
      createdAt: json['createdAt'],
      postCreatorUid: json['postCreatorUid'] as String,
      postId: json['postId'] as String,
      postRef: json['postRef'],
    );

Map<String, dynamic> _$$_PostLikeToJson(_$_PostLike instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'createdAt': instance.createdAt,
      'postCreatorUid': instance.postCreatorUid,
      'postId': instance.postId,
      'postRef': instance.postRef,
    };
