//Stiring にする
enum TokenType { following, likePost }

String returnTokenTypeString({required TokenType tokenType}) =>
    tokenType.toString().substring(10);

String followingTokenTypeString =
    returnTokenTypeString(tokenType: TokenType.following);

String likePostTokenType = returnTokenTypeString(tokenType: TokenType.likePost);

TokenType mapToTokenType({required Map<String, dynamic> tokenMap}) {
  final String tokenTypeString = tokenMap["tokenType"];
  if (tokenTypeString == followingTokenTypeString) {
    return TokenType.following;
  } else {
    return TokenType.likePost;
  }
}
