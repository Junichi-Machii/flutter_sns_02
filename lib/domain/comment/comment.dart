import 'package:flutter/rendering.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
abstract class Comment with _$Comment {
  const factory Comment({
    required dynamic createdAt,
    required int postCommentReplyCount,
    required int likeCount,
    required String comment,
    required String userName,
    required String userImageURL,
    required String uid,
    required String postCommentId,
  }) = _Comment;
  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
