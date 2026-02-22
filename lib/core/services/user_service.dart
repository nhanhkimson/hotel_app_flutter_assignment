import 'package:flutter/foundation.dart';
import 'package:hotel_app/core/services/auth_service.dart';

/// User Service for managing user data and password
class UserService extends ChangeNotifier {
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  final AuthService _authService = AuthService();

  // Demo user data
  String _currentPassword = '123456';
  String _fullName = 'Chheng Seyha';
  String _email = 'user@example.com';
  String _dateOfBirth = '26 June 2001';
  String _gender = 'Male';

  String get currentPassword => _currentPassword;
  String get fullName => _fullName;
  String get email => _email;
  String get dateOfBirth => _dateOfBirth;
  String get gender => _gender;

  /// Change password
  Future<PasswordChangeResult> changePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    // Validate inputs
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      return PasswordChangeResult.failure('All fields are required');
    }

    // Check if old password is correct - check both UserService and AuthService
    final correctOldPassword = _currentPassword == oldPassword || 
                               (_authService.isLoggedIn && _authService.currentPassword == oldPassword);
    
    if (!correctOldPassword) {
      return PasswordChangeResult.failure('Old password is incorrect');
    }

    // Check if new password matches confirmation
    if (newPassword != confirmPassword) {
      return PasswordChangeResult.failure('New password and confirmation do not match');
    }

    // Check password length
    if (newPassword.length < 6) {
      return PasswordChangeResult.failure('Password must be at least 6 characters');
    }

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Update password
    _currentPassword = newPassword;
    
    // Update auth service password if user is logged in
    if (_authService.isLoggedIn) {
      // Sync password with auth service
      _authService.updatePassword(newPassword);
    }

    notifyListeners();
    return PasswordChangeResult.success('Password changed successfully');
  }

  /// Update profile
  Future<bool> updateProfile({
    String? fullName,
    String? dateOfBirth,
    String? gender,
  }) async {
    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 300));

    if (fullName != null) _fullName = fullName;
    if (dateOfBirth != null) _dateOfBirth = dateOfBirth;
    if (gender != null) _gender = gender;

    notifyListeners();
    return true;
  }

  /// Reset password (for forgot password flow - no old password required)
  Future<PasswordChangeResult> resetPassword(
    String newPassword,
    String confirmPassword,
  ) async {
    // Validate inputs
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      return PasswordChangeResult.failure('All fields are required');
    }

    // Check if new password matches confirmation
    if (newPassword != confirmPassword) {
      return PasswordChangeResult.failure('New password and confirmation do not match');
    }

    // Check password length
    if (newPassword.length < 6) {
      return PasswordChangeResult.failure('Password must be at least 6 characters');
    }

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Update password
    _currentPassword = newPassword;
    
    // Update auth service password if user is logged in
    if (_authService.isLoggedIn) {
      // Sync password with auth service
      _authService.updatePassword(newPassword);
    }

    notifyListeners();
    return PasswordChangeResult.success('Password reset successfully');
  }

  /// Get user info
  Map<String, dynamic> getUserInfo() {
    return {
      'fullName': _fullName,
      'email': _email,
      'dateOfBirth': _dateOfBirth,
      'gender': _gender,
    };
  }
}

/// Password Change Result
class PasswordChangeResult {
  final bool success;
  final String message;

  PasswordChangeResult._(this.success, this.message);

  factory PasswordChangeResult.success(String message) {
    return PasswordChangeResult._(true, message);
  }

  factory PasswordChangeResult.failure(String message) {
    return PasswordChangeResult._(false, message);
  }
}

