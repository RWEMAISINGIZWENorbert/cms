import 'package:hive/hive.dart';

part 'department.g.dart';

@HiveType(typeId: 7)
class Department {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<String> categoryIds;

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.categoryIds,
  });

  // Default departments for MVP
  static List<Department> getDefaultDepartments() {
    return [
      Department(
        id: '1',
        name: 'health',
        description: 'Handles The issues in the health departmnet',
        categoryIds: ['1', '3', '5'],
      ),
      Department(
        id: '2',
        name: 'education',
        description: 'Manages The issue occured i the educational field',
        categoryIds: ['4'], // Facility Issues
      ),
      Department(
        id: '3',
        name: 'transport',
        description: 'Solve the poblem for those who meet with the issues in the Transport',
        categoryIds: ['6'], // Training Request
      ),
      Department(
        id: '4',
        name: 'agriculture',
        description: 'Handle the serviced for the farmers and the clents of the farmers',
        categoryIds: ['2'],
      ),
      Department(
        id: '5',
        name: 'government',
        description: 'Handle the issues for the government',
        categoryIds: ['2'],
      ),
      Department(
        id: '6',
        name: 'technology',
        description: 'Handle the issues for the Technology',
        categoryIds: ['2'],
      ),
      Department(
        id: '6',
        name: 'environment',
        description: 'Handle the issues for the Technology',
        categoryIds: ['2'], 
      ),
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'categoryIds': categoryIds,
    };
  }

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryIds: List<String>.from(json['categoryIds']),
    );
  }
} 