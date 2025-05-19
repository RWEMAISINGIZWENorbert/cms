class Category {
  final String id;
  final String name;
  final String description;
  final String? departmentId; // For future use when linking with departments

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.departmentId,
  });

  // For MVP, we'll have some predefined categories
  static List<Category> getDefaultCategories() {
    return [
      Category(
        id: '1',
        name: 'health',
        description: 'Problems related to the health secctor',
      ),
      Category(
        id: '2',
        name: 'education',
        description: 'Problems related to the educational stuffs',
      ),
      Category(
        id: '3',
        name: 'transport',
        description: 'Problems faced by the passengers, drivers and all of the other in the transport field',
      ),
      Category(
        id: '4',
        name: 'agriculture',
        description: 'Those problems in the agriculture field',
      ),
      Category(
        id: '5',
        name: 'government',
        description: 'The problems related to the legal serives and the government',
      ),
      Category(
        id: '6',
        name: 'technology',
        description: 'The problems related to teh ICT,innvoation and technology',
      ),
      Category(
        id: '7',
        name: 'environment',
        description: 'The problems related to the stuffs that surround us',
      ),
    ];
  }

  // Convert to and from JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'departmentId': departmentId,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      departmentId: json['departmentId'],
    );
  }
} 