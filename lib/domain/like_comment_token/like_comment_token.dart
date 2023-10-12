import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_comment_token.freezed.dart';
part 'like_comment_token.g.dart';

@freezed
abstract class LikeCommentToken with _$LikeCommentToken {
  const factory LikeCommentToken({
    required dynamic createdAt,
    required String activeUid,
    required String passiveUid,
    required dynamic commentRef,
    required String commentId,
    required String tokenId,
    required String tokenType,
  }) = _LikeCommentToken;
  factory LikeCommentToken.fromJson(Map<String, dynamic> json) =>
      _$LikeCommentTokenFromJson(json);
}
