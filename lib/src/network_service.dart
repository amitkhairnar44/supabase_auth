part of supabase_auth;

class _NetworkService {
  static _NetworkService _instance = _NetworkService.internal();

  factory _NetworkService() => _instance;

  _NetworkService.internal();

  Future<dynamic> get(String url, {Map<String, String> headers}) async {
    return await http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      //final int statusCode = response.statusCode;
      return jsonDecode(res);
    });
  }

  Future<dynamic> post(String url,
      {Map<String, String> headers, body, encoding}) async {
    return await http
        .post(url, body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      //final int statusCode = response.statusCode;
      return res.isNotEmpty ? jsonDecode(res) : null;
    });
  }
}


