import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 8)
class User extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String department;

  @HiveField(3)
  final String telephone;

  @HiveField(4)
  final String id;

  User({
    required this.name,
    required this.email,
    required this.department,
    required this.telephone,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['userName'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
      telephone: json['telephone']?.toString() ?? '',
      id: json['_id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': name,
      'email': email,
      'department': department,
      'telephone': telephone,
      '_id': id,
    };
  }
} 