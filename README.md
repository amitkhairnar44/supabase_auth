# supabase_auth

A Supabase Auth Dart package.

## Usage

```dart
import 'package:supabase_auth/supabase_auth.dart';

// Initialise auth with apikey and url provided by Supabase
var _auth = SupabaseAuth(apiKey: YOUR_APIKEY, supabaseUrl: SUPABASE_URL);

// Sign up user using email and password
var user = await _auth.signUp(email: "example@xyz.com",password: "yourpassword");

// Sign in using email and password
// This will return userCredentials such as access token, refresh token alongwith current user
var userCredential = await _auth.signIn(email: "example@xyz.com",password: "yourpassword");
```

### Logout
```dart
This will logout current user
_auth.logout();
```
