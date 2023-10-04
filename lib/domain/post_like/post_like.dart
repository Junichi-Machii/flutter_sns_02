import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_like.freezed.dart';
part 'post_like.g.dart';

//投稿がいいねされた時の印
@freezed
abstract class PostLike with _$PostLike {
  const factory PostLike({
    required String activeUid,
    required dynamic createdAt,
    required String postCreatorUid,
    required String postId,
    required dynamic postRef,
  }) = _PostLike;
  factory PostLike.fromJson(Map<String, dynamic> json) =>
      _$PostLikeFromJson(json);
}
