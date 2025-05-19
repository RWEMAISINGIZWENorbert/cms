import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'compliant.g.dart';

@HiveType(typeId: 3)
enum CompliantStatus {
  @HiveField(0)
  open,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  resolved,
  @HiveField(3)
  closed,
  @HiveField(4)
  rejected;

  String get displayName {
    switch (this) {
      case CompliantStatus.open:
        return 'Open';
      case CompliantStatus.inProgress:
        return 'In Progress';
      case CompliantStatus.resolved:
        return 'Resolved';
      case CompliantStatus.closed:
        return 'Closed';
      case CompliantStatus.rejected:
        return 'Rejected';
    }
  }

  Color get color {
    switch (this) {
      case CompliantStatus.open:
        return Colors.blue;
      case CompliantStatus.inProgress:
        return Colors.orange;
      case CompliantStatus.resolved:
        return Colors.green;
      case CompliantStatus.closed:
        return Colors.grey;
      case CompliantStatus.rejected:
        return Colors.red;
    }
  }
}

@HiveType(typeId: 4)
enum CompliantPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  normal,
  @HiveField(2)
  high,
  @HiveField(3)
  urgent;

  String get displayName {
    switch (this) {
      case CompliantPriority.low:
        return 'Low';
      case CompliantPriority.normal:
        return 'Normal';
      case CompliantPriority.high:
        return 'High';
      case CompliantPriority.urgent:
        return 'Urgent';
    }
  }

  Color get color {
    switch (this) {
      case CompliantPriority.low:
        return Colors.green;
      case CompliantPriority.normal:
        return Colors.blue;
      case CompliantPriority.high:
        return Colors.orange;
      case CompliantPriority.urgent:
        return Colors.red;
    }
  }
}

@HiveType(typeId: 5)
enum SyncStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  synced,
  @HiveField(2)
  failed;

  String get displayName {
    switch (this) {
      case SyncStatus.pending:
        return 'Pending';
      case SyncStatus.synced:
        return 'Synced';
      case SyncStatus.failed:
        return 'Failed';
    }
  }

  Color get color {
    switch (this) {
      case SyncStatus.pending:
        return Colors.orange;
      case SyncStatus.synced:
        return Colors.green;
      case SyncStatus.failed:
        return Colors.red;
    }
  }
}

@HiveType(typeId: 6)
class Compliant {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final CompliantStatus status;

  @HiveField(4)
  final String categoryId;

  @HiveField(5)
  final CompliantPriority priority;

  @HiveField(6)
  final String location;

  @HiveField(7)
  final String submittedBy;

  @HiveField(8)
  final String telephoneNumber;

  @HiveField(9)
  final String? assignedTo;

  @HiveField(10)
  final DateTime createdAt;

  @HiveField(11)
  final DateTime updatedAt;

  @HiveField(12)
  final List<String> attachments;

  @HiveField(13)
  final SyncStatus syncStatus;

  @HiveField(14)
  final String? serverId;

  const Compliant({
    required this.id,
    required this.title,
    required this.description,
    this.status = CompliantStatus.open,
    required this.categoryId,
    required this.priority,
    required this.location,
    required this.submittedBy,
    required this.telephoneNumber,
    this.assignedTo,
    required this.createdAt,
    required this.updatedAt,
    required this.attachments,
    this.syncStatus = SyncStatus.pending,
    this.serverId,
  });

  // Create a new Compliant with default values
  factory Compliant.create({
    required String id,
    required String title,
    required String description,
    required String categoryId,
    required String location,
    required String submittedBy,
    required String telephoneNumber,
    List<String> attachments = const [],
  }) {
    final now = DateTime.now();
    return Compliant(
      id: id,
      title: title,
      description: description,
      status: CompliantStatus.open,
      categoryId: categoryId,
      priority: CompliantPriority.normal,
      location: location,
      submittedBy: submittedBy,
      telephoneNumber: telephoneNumber,
      createdAt: now,
      updatedAt: now,
      attachments: attachments,
      syncStatus: SyncStatus.pending,
    );
  }

  // Create a Compliant from JSON
  factory Compliant.fromJson(Map<String, dynamic> json) {
    return Compliant(
      id: json['_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: CompliantStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['status'] as String).toLowerCase(),
        orElse: () => CompliantStatus.open,
      ),
      categoryId: json['category'] as String,
      priority: CompliantPriority.normal,
      location: json['location'] as String,
      submittedBy: json['submittedBy'] as String,
      telephoneNumber: json['telephoneNumber'] as String,
      assignedTo: null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      attachments: [],
      syncStatus: SyncStatus.synced,
      serverId: json['_id'] as String,
    );
  }

  // Convert Compliant to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': serverId ?? id, // Use server ID if available
      'title': title,
      'description': description,
      'status': status.name,
      'categoryId': categoryId,
      'priority': priority.name,
      'location': location,
      'submitted_by': submittedBy,
      'telephone_number': telephoneNumber,
      'assigned_to': assignedTo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'attachments': attachments,
      'sync_status': syncStatus.name,
    };
  }

  // Create a copy of the Compliant with some fields updated
  Compliant copyWith({
    String? id,
    String? title,
    String? description,
    CompliantStatus? status,
    String? categoryId,
    CompliantPriority? priority,
    String? location,
    String? submittedBy,
    String? telephoneNumber,
    String? assignedTo,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? attachments,
    SyncStatus? syncStatus,
    String? serverId,
  }) {
    return Compliant(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      categoryId: categoryId ?? this.categoryId,
      priority: priority ?? this.priority,
      location: location ?? this.location,
      submittedBy: submittedBy ?? this.submittedBy,
      telephoneNumber: telephoneNumber ?? this.telephoneNumber,
      assignedTo: assignedTo ?? this.assignedTo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      attachments: attachments ?? this.attachments,
      syncStatus: syncStatus ?? this.syncStatus,
      serverId: serverId ?? this.serverId,
    );
  }

  // Get relative time string (e.g., "2 hours ago")
  String getRelativeTimeString() {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

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

  @override
  String toString() {
    return 'Compliant(id: $id, status: ${status.name}, priority: ${priority.name})';
  }
}
