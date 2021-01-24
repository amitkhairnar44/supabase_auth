part of supabase_auth;

enum AuthState { SIGNED_IN, SIGNED_OUT }

abstract class AuthStateListener {
  void onAuthStateChanged(AuthState state);
}

class SupabaseAuth {
  static SupabaseAuth _instance;

  /// User credentials of current logged-in user
  UserCredential _userCredential;

  _AuthApi _api;

  /// List of [AuthStateListener]
  List<AuthStateListener> _subscribers;

  /// Default constructor to initialise
  factory SupabaseAuth(
      {@required String apiKey, @required String supabaseUrl}) {
    if (_instance == null) {
      _instance = SupabaseAuth._(apiKey: apiKey, supabaseUrl: supabaseUrl);
      return _instance;
    }
    return _instance;
  }

  /// Private Constructor
  SupabaseAuth._({String apiKey, String supabaseUrl}) {
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
