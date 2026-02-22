import 'package:flutter/foundation.dart';
import 'package:hotel_app/core/services/data_service.dart';
import 'package:hotel_app/features/notifications/models/notification_model.dart';

/// Service for managing notifications
class NotificationService extends ChangeNotifier {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final DataService _dataService = DataService();
  final List<NotificationModel> _notifications = [];
  bool _isInitialized = false;

  List<NotificationModel> get notifications => List.unmodifiable(_notifications);
  List<NotificationModel> get unreadNotifications =>
      _notifications.where((n) => !n.isRead).toList();
  int get unreadCount => unreadNotifications.length;

  /// Initialize notifications from JSON data
  Future<void> initialize() async {
    if (_isInitialized && _notifications.isNotEmpty) return;

    try {
      // Ensure data is loaded
      if (!_dataService.isLoaded) {
        await _dataService.loadData();
      }

      // Load notifications from JSON
      final notificationsData = _dataService.getNotifications();
      _notifications.clear();
      
      for (var notificationData in notificationsData) {
        try {
          final notification = NotificationModel.fromJson(notificationData);
          _notifications.add(notification);
        } catch (e) {
          print('Error parsing notification: $e');
        }
      }

      // Sort by date (newest first)
      _notifications.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      print('Error initializing notifications: $e');
      _isInitialized = false;
    }
  }

  /// Add a new notification
  void addNotification(NotificationModel notification) {
    _notifications.insert(0, notification);
    notifyListeners();
  }

  /// Mark notification as read
  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((n) => n.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      notifyListeners();
    }
  }

  /// Mark all notifications as read
  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      if (!_notifications[i].isRead) {
        _notifications[i] = _notifications[i].copyWith(isRead: true);
      }
    }
    notifyListeners();
  }

  /// Delete a notification
  void deleteNotification(String notificationId) {
    _notifications.removeWhere((n) => n.id == notificationId);
    notifyListeners();
  }

  /// Clear all notifications
  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }

  /// Get notifications by type
  List<NotificationModel> getNotificationsByType(String type) {
    return _notifications.where((n) => n.type == type).toList();
  }
}

