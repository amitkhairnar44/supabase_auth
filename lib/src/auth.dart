part of supabase_auth;

enum AuthState { SIGNED_IN, SIGNED_OUT }

abstract class AuthStateListener {
  void onAuthStateChanged(AuthState state);
}

class SupabaseAuth {
  UserCredential _userCredential;
  _AuthApi _api;
  List<AuthStateListener> _subscribers;

  SupabaseAuth({@required String apiKey, @required String supabaseUrl}) {
    _subscribers = List<AuthStateListener>();
    _api = _AuthApi(apiKey: apiKey, supabaseUrl: supabaseUrl);
  }

  /// Current logged-in user
  UserCredential get currentUser => _userCredential;

  /// Dispose off all the listeners
  void dispose(AuthStateListener listener) {
    _subscribers.remove(listener);
  }

  /// Logout current user.
  Future<dynamic> logout() async {
    assert(_userCredential != null);

    var _c = await _api.logout("Bearer ${_userCredential.accessToken}");

    if (_c == null) {
      notify(AuthState.SIGNED_OUT);
      _userCredential = null;
    }

    return null;
  }

  /// Notify the [AuthStateListener] about the state change
  void notify(AuthState state) {
    _subscribers.forEach((AuthStateListener s) => s.onAuthStateChanged(state));
  }

  /// Sign in a user with the given email address and password.
  Future<UserCredential> signIn(
      {@required String email, @required String password}) async {
    assert(email != null);
    assert(password != null);

    UserCredential _c = await _api.signInUsingEmailAndPassword(
        email: email, password: password);
    if (_c != null) {
      _userCredential = _c;
      notify(AuthState.SIGNED_IN);
      return _c;
    }

    return null;
  }

  /// Creates a new user account with the given email address and password.
  Future<User> signUp(
      {@required String email, @required String password}) async {
    assert(email != null);
    assert(password != null);

    return await _api.signUpUsingEmailAndPassword(
        email: email, password: password);
  }

  /// Subscribe to a [AuthStateListener]
  void subscribe(AuthStateListener listener) {
    _subscribers.add(listener);
  }
}
