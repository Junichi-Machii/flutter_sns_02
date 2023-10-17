import 'package:freezed_annotation/freezed_annotation.dart';

part 'like_reply_token.freezed.dart';
part 'like_reply_token.g.dart';

@freezed
abstract class LikeReplyToken with _$LikeReplyToken {
  const factory LikeReplyToken({
    required dynamic createdAt,
    required String activeUid,
    required String passiveUid,
    required dynamic postCommentReplyRef,
    required String postCommentReplyId,
    required String tokenId,
    required String tokenType,
  }) = _LikeReplyToken;
  factory LikeReplyToken.fromJson(Map<String, dynamic> json) =>
      _$LikeReplyTokenFromJson(json);
}
