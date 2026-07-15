import 'package:flutter/foundation.dart';

enum NotificationType {
  student,
  teacher,
  admin,
}

class AppNotification {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime createdAt;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    DateTime? createdAt,
    this.isRead = false,
  }) : createdAt = createdAt ?? DateTime.now();
}

class NotificationStore {
  NotificationStore._();

  static final ValueNotifier<List<AppNotification>> notifications =
      ValueNotifier<List<AppNotification>>([]);

  static void add(AppNotification notification) {
    notifications.value = [
      notification,
      ...notifications.value,
    ];
  }

  static void markAsRead(String id) {
    notifications.value = notifications.value.map((notification) {
      if (notification.id == id) {
        notification.isRead = true;
      }
      return notification;
    }).toList();
  }

  static void clear() {
    notifications.value = [];
  }
}
