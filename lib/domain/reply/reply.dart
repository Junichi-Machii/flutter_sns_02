import 'package:freezed_annotation/freezed_annotation.dart';

part 'reply.freezed.dart';
part 'reply.g.dart';

@freezed
abstract class Reply with _$Reply {
  const factory Reply({
    required dynamic createdAt,
    required String reply,
    required int likeCount,
    required dynamic postRef,
    required dynamic postCommentRef,
    required String postCommentReplyId,
    required String userName,
    required String uid,
    required String userImageURL,
  }) = _Reply;
  factory Reply.fromJson(Map<String, dynamic> json) => _$ReplyFromJson(json);
}
