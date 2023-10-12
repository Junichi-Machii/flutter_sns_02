// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      hashTags:
          (json['hashTags'] as List<dynamic>).map((e) => e as String).toList(),
      imageURL: json['imageURL'] as String,
      likeCount: json['likeCount'] as int,
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
      commentCount: json['commentCount'] as int,
      postId: json['postId'] as String,
      text: json['text'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'hashTags': instance.hashTags,
      'imageURL': instance.imageURL,
      'likeCount': instance.likeCount,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'commentCount': instance.commentCount,
      'postId': instance.postId,
      'text': instance.text,
      'uid': instance.uid,
    };
