//Stiring にする
enum TokenType {
  following,
  likePost,
  likeReply,
  likeComment,
  muteUser,
  mistake
}

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

String muteUserTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.muteUser);

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
  } else if (tokenTypeString == muteUserTokenTypeString) {
    return TokenType.muteUser;
  } else {
    return TokenType.mistake;
  }
}
