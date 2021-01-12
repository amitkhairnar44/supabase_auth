part of supabase_auth;

class User {
  /// Unique ID assigned to the user
  final String id;

  final String aud;

  final String role;

  /// User's email address
  final String email;

  /// Date of confirmation sent
  ///
  /// Format: 2021-01-07T04:49:18.475191Z
  final String confirmationSentAt;

  /// Date of creation
  ///
  /// Format: 2021-01-07T04:49:18.475191Z
  final String createdAt;

  /// Date updated
  ///
  /// Format: 2021-01-07T04:49:18.475191Z
  final String updatedAt;

  final Map<String, dynamic> appMetadata;

  final Map<String, dynamic> userMetadata;

  User(
      {this.id,
      this.aud,
      this.role,
      this.email,
      this.confirmationSentAt,
      this.createdAt,
      this.updatedAt,
      this.appMetadata,
      this.userMetadata});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        id: parsedJson['id'],
        aud: parsedJson['aud'],
        role: parsedJson['role'],
        email: parsedJson['email'],
        confirmationSentAt: parsedJson['confirmation_sent_at'],
        createdAt: parsedJson['created_at'],
        updatedAt: parsedJson['updated_at'],
        appMetadata: parsedJson['app_metadata'],
        userMetadata: parsedJson['user_metadata']);
  }
}
