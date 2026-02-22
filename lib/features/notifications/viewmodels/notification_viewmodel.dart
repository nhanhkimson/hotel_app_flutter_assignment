import 'package:flutter/material.dart';
import 'package:hotel_app/core/base/base_viewmodel.dart';
import 'package:hotel_app/core/services/notification_service.dart';
import 'package:hotel_app/features/notifications/models/notification_model.dart';

/// ViewModel for Notifications Screen
class NotificationViewModel extends BaseViewModel {
  final NotificationService _notificationService = NotificationService();

  List<NotificationModel> get notifications => _notificationService.notifications;
  int get unreadCount => _notificationService.unreadCount;
  bool get hasNotifications => notifications.isNotEmpty;

  @override
  void init() {
    super.init();
    _notificationService.addListener(_onNotificationServiceChanged);
    loadNotifications();
  }

  @override
  void dispose() {
    _notificationService.removeListener(_onNotificationServiceChanged);
    super.dispose();
  }

  void _onNotificationServiceChanged() {
    notifyListeners();
  }

  /// Load notifications
  Future<void> loadNotifications() async {
    await executeWithLoading(() async {
      await _notificationService.initialize();
      notifyListeners();
    });
  }

  /// Mark notification as read
  void markAsRead(String notificationId) {
    _notificationService.markAsRead(notificationId);
  }

  /// Mark all as read
  void markAllAsRead() {
    _notificationService.markAllAsRead();
  }

  /// Delete notification
  void deleteNotification(String notificationId) {
    _notificationService.deleteNotification(notificationId);
  }

  /// Clear all notifications
  void clearAll() {
    _notificationService.clearAll();
  }

  /// Get formatted time string
  String getFormattedTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  /// Get notification icon based on type
  IconData getNotificationIcon(String type) {
    switch (type) {
      case 'booking':
        return Icons.calendar_today;
      case 'promotion':
        return Icons.local_offer;
      case 'reminder':
        return Icons.access_time;
      default:
        return Icons.notifications;
    }
  }

  /// Get notification color based on type
  int getNotificationColor(String type) {
    switch (type) {
      case 'booking':
        return 0xFF4CAF50; // Green
      case 'promotion':
        return 0xFFFF9800; // Orange
      case 'reminder':
        return 0xFF2196F3; // Blue
      default:
        return 0xFF9E9E9E; // Grey
    }
  }
}

