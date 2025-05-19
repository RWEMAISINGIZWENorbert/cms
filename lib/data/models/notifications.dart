import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'notifications.g.dart';

@HiveType(typeId: 1)
enum NotificationType {
  @HiveField(0)
  statusUpdate,
  @HiveField(1)
  assignment,
  @HiveField(2)
  newComplaint,
  @HiveField(3)
  comment,
  @HiveField(4)
  reminder;

  String get displayName {
    switch (this) {
      case NotificationType.statusUpdate:
        return 'Status Update';
      case NotificationType.assignment:
        return 'Assignment';
      case NotificationType.newComplaint:
        return 'New Complaint';
      case NotificationType.comment:
        return 'Comment';
      case NotificationType.reminder:
        return 'Reminder';
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.statusUpdate:
        return Icons.update;
      case NotificationType.assignment:
        return Icons.assignment;
      case NotificationType.newComplaint:
        return Icons.warning;
      case NotificationType.comment:
        return Icons.comment;
      case NotificationType.reminder:
        return Icons.notifications;
    }
  }

  Color get color {
    switch (this) {
      case NotificationType.statusUpdate:
        return Colors.blue;
      case NotificationType.assignment:
        return Colors.green;
      case NotificationType.newComplaint:
        return Colors.orange;
      case NotificationType.comment:
        return Colors.purple;
      case NotificationType.reminder:
        return Colors.amber;
    }
  }
}

@HiveType(typeId: 2)
class Notification {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final NotificationType type;

  @HiveField(2)
  final String message;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final bool read;

  const Notification({
    required this.id,
    required this.type,
    required this.message,
    required this.createdAt,
    this.read = false,
  });

  // Create a new notification with current timestamp
  factory Notification.create({
    required String id,
    required NotificationType type,
    required String message,
  }) {
    return Notification(
      id: id,
      type: type,
      message: message,
      createdAt: DateTime.now(),
      read: false,
    );
  }

  // Create a Notification from JSON
  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'] as String,
      type: NotificationType.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['type'] as String).toLowerCase(),
        orElse: () => NotificationType.statusUpdate,
      ),
      message: json['message'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      read: json['read'] as bool? ?? false,
    );
  }

  // Convert Notification to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'read': read,
    };
  }

  // Create a copy of the Notification with some fields updated
  Notification copyWith({
    String? id,
    NotificationType? type,
    String? message,
    DateTime? createdAt,
    bool? read,
  }) {
    return Notification(
      id: id ?? this.id,
      type: type ?? this.type,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      read: read ?? this.read,
    );
  }

  // Mark notification as read
  Notification markAsRead() {
    return copyWith(read: true);
  }

  // Mark notification as unread
  Notification markAsUnread() {
    return copyWith(read: false);
  }

  // Get relative time string (e.g., "2 hours ago")
  String get relativeTime {
    final difference = DateTime.now().difference(createdAt);
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

  // Check if notification is recent (within last 24 hours)
  bool get isRecent {
    return DateTime.now().difference(createdAt).inHours < 24;
  }

  @override
  String toString() {
    return 'Notification(id: $id, type: ${type.name}, read: $read)';
  }
}
