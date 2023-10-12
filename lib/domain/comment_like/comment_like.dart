import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_like.freezed.dart';
part 'comment_like.g.dart';

//投稿がいいねされた時の印
@freezed
abstract class CommentLike with _$CommentLike {
  const factory CommentLike({
    required String activeUid,
    required dynamic createdAt,
    required String postCommentCreatorUid,
    required String postCommentId,
    required dynamic postCommentRef,
  }) = _CommentLike;
  factory CommentLike.fromJson(Map<String, dynamic> json) =>
      _$CommentLikeFromJson(json);
}
