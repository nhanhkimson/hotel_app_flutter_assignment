import 'package:flutter/foundation.dart';

/// Base ViewModel class for all ViewModels
/// Provides common functionality like loading state and error handling
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasError => _error != null;

  /// Set loading state
  void setLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  /// Set error message
  void setError(String? errorMessage) {
    if (_error != errorMessage) {
      _error = errorMessage;
      notifyListeners();
    }
  }

  /// Clear error
  void clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  /// Initialize ViewModel
  void init() {}

  /// Dispose resources
  @override
  void dispose() {
    super.dispose();
  }

  /// Execute async operation with loading and error handling
  Future<T?> executeWithLoading<T>(Future<T> Function() operation) async {
    try {
      setLoading(true);
      clearError();
      final result = await operation();
      return result;
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }
}

