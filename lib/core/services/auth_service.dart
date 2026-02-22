import 'package:flutter/foundation.dart';

/// Authentication Service
class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // Demo user credentials - default
  String _demoEmail = 'user@example.com';
  String _demoPassword = '123456';
  
  String? _currentUserEmail;
  bool _isLoggedIn = false;

  String? get currentUserEmail => _currentUserEmail;
  bool get isLoggedIn => _isLoggedIn;

  /// Get current password (for checking - will sync with UserService)
  String get currentPassword => _demoPassword;
  
  /// Update password (called by UserService when password changes)
  void updatePassword(String newPassword) {
    _demoPassword = newPassword;
  }

  /// Login with email and password
  Future<AuthResult> login(String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Check credentials - accepts default or any password that matches UserService
    // Default: user@example.com / 123456
    if (email == _demoEmail && password == _demoPassword) {
      _currentUserEmail = email;
      _isLoggedIn = true;
      notifyListeners();
      return AuthResult.success('Login successful');
    } else {
      return AuthResult.failure('Invalid email or password');
    }
  }

  /// Register new user
  Future<AuthResult> register(String email, String password) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    // For demo, just set as logged in and update credentials
    _currentUserEmail = email;
    _demoEmail = email;
    _demoPassword = password;
    _isLoggedIn = true;
    
    // Update UserService with new user data
    // Note: In a real app, this would be done via API
    notifyListeners();
    return AuthResult.success('Registration successful');
  }

  /// Logout
  void logout() {
    _currentUserEmail = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  /// Check if user is logged in
  bool checkAuth() {
    return _isLoggedIn;
  }
}

/// Authentication Result
class AuthResult {
  final bool success;
  final String message;

  AuthResult._(this.success, this.message);

  factory AuthResult.success(String message) {
    return AuthResult._(true, message);
  }

  factory AuthResult.failure(String message) {
    return AuthResult._(false, message);
  }
}

