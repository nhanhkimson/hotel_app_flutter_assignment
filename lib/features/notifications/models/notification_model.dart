/// Notification model
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type; // 'booking', 'promotion', 'reminder', 'system'
  final DateTime dateTime;
  final bool isRead;
  final String? actionUrl; // Optional deep link or action

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.dateTime,
    this.isRead = false,
    this.actionUrl,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      type: json['type']?.toString() ?? 'system',
      dateTime: json['dateTime'] != null
          ? DateTime.parse(json['dateTime'])
          : DateTime.now(),
      isRead: json['isRead'] == true,
      actionUrl: json['actionUrl']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'dateTime': dateTime.toIso8601String(),
      'isRead': isRead,
      'actionUrl': actionUrl,
    };
  }

  NotificationModel copyWith({
    String? id,
    String? title,
    String? message,
    String? type,
    DateTime? dateTime,
    bool? isRead,
    String? actionUrl,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      isRead: isRead ?? this.isRead,
      actionUrl: actionUrl ?? this.actionUrl,
    );
  }
}

