part of supabase_auth;

class _AuthApi {
  final _NetworkService _networkService = _NetworkService();
  String _apiKey;
  String _supabaseUrl;

  _AuthApi({@required String apiKey, @required String supabaseUrl}) {
    this._apiKey = apiKey;
    this._supabaseUrl = supabaseUrl;
  }

  Future<User> signUpUsingEmailAndPassword(
      {@required String email, @required String password}) async {
    Map<String, dynamic> parsedJson = await _networkService.post(
      _supabaseUrl + '/auth/v1/signup',
      headers: {"apikey": _apiKey, "Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return User.fromJson(parsedJson);
  }

  Future<UserCredential> signInUsingEmailAndPassword(
      {@required String email, @required String password}) async {
    Map<String, dynamic> parsedJson = await _networkService.post(
      _supabaseUrl + '/auth/v1/token?grant_type=password',
      headers: {"apikey": _apiKey, "Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    return UserCredential.fromJson(parsedJson);
  }

  //TODO: Handle logout properly. Status code : 204
  Future<dynamic> logout(String accessToken) async {
    Map<String, dynamic> parsedJson = await _networkService.post(
      _supabaseUrl + '/auth/v1/logout',
      headers: {
        "apikey": _apiKey,
        "Content-Type": "application/json",
        "Authorization": accessToken
      },
    );

    return parsedJson;
  }
}
