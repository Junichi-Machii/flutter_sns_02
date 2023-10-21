// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_mute.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserMute _$$_UserMuteFromJson(Map<String, dynamic> json) => _$_UserMute(
      activeUid: json['activeUid'] as String,
      passiveUid: json['passiveUid'] as String,
      createdAt: json['createdAt'],
      passiveUserRef: json['passiveUserRef'],
    );

Map<String, dynamic> _$$_UserMuteToJson(_$_UserMute instance) =>
    <String, dynamic>{
      'activeUid': instance.activeUid,
      'passiveUid': instance.passiveUid,
      'createdAt': instance.createdAt,
      'passiveUserRef': instance.passiveUserRef,
    };
