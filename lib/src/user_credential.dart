part of supabase_auth;

class UserCredential {
  /// Access token generated for the session
  final String accessToken;

  /// Type of the access token
  final String tokenType;

  /// Refresh token to generate new token
  /// in current [accessToken] expires
  final String refreshToken;

  /// Time of expiration of the [accessToken] in seconds
  final int expiresIn;

  /// User linked to current session
  final User user;

  UserCredential(
      {this.accessToken,
      this.tokenType,
      this.refreshToken,
      this.expiresIn,
      this.user});

  factory UserCredential.fromJson(Map<String, dynamic> parsedJson) {
    return UserCredential(
        user: parsedJson['user'] != null
            ? User.fromJson(parsedJson['user'])
            : null,
        expiresIn: parsedJson['expires_in'],
        tokenType: parsedJson['token_type'],
        accessToken: parsedJson['access_token'],
        refreshToken: parsedJson['refresh_token']);
  }

  @override
  int get hashCode =>
      accessToken.hashCode ^
      tokenType.hashCode ^
      refreshToken.hashCode ^
      expiresIn.hashCode ^
      user.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCredential &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          tokenType == other.tokenType &&
          refreshToken == other.refreshToken &&
          expiresIn == other.expiresIn &&
          user == other.user;

  @override
  String toString() {
    return 'UserCredential{accessToken: $accessToken, tokenType: $tokenType, refreshToken: $refreshToken, expiresIn: $expiresIn, user: $user}';
  }
}
