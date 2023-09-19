// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FirestoreUser _$$_FirestoreUserFromJson(Map<String, dynamic> json) =>
    _$_FirestoreUser(
      createdAt: json['createdAt'],
      email: json['email'] as String,
      followerCount: json['followerCount'] as int,
      followingCount: json['followingCount'] as int,
      updatedAt: json['updatedAt'],
      userName: json['userName'] as String,
      userImageURL: json['userImageURL'] as String,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$$_FirestoreUserToJson(_$_FirestoreUser instance) =>
    <String, dynamic>{
      'createdAt': instance.createdAt,
      'email': instance.email,
      'followerCount': instance.followerCount,
      'followingCount': instance.followingCount,
      'updatedAt': instance.updatedAt,
      'userName': instance.userName,
      'userImageURL': instance.userImageURL,
      'uid': instance.uid,
    };
