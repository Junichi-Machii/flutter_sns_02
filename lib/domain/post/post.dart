import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required dynamic createdAt,
    required dynamic updatedAt,
    required List<String> hashTags,
    required String imageURL,
    required int likeCount,
    required String userName,
    required String userImageURL,
    required String postId,
    required String text,
    required String uid,
  }) = _Post;
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
