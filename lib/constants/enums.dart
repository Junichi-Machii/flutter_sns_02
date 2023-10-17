//Stiring にする
enum TokenType { following, likePost, likeReply, likeComment, mistake }

String returnTokenTypeString({required TokenType tokenType}) =>
    tokenType.toString().substring(10);

String followingTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.following);

String likePostTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.likePost);
String likeCommentTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.likeComment);
String likeReplyTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.likeReply);

TokenType mapToTokenType({required Map<String, dynamic> tokenMap}) {
  final String tokenTypeString = tokenMap["tokenType"];
  if (tokenTypeString == followingTokenTypeString) {
    return TokenType.following;
  } else if (tokenTypeString == likePostTokenTypeString) {
    return TokenType.likePost;
  } else if (tokenTypeString == likeCommentTokenTypeString) {
    return TokenType.likeComment;
  } else if (tokenTypeString == likeReplyTokenTypeString) {
    return TokenType.likeReply;
  } else {
    return TokenType.mistake;
  }
}
