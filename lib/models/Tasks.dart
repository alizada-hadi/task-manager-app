class Task {
  final String id;
  final String title;
  final String? description; // Still optional
  final bool completed;
  final String userId;
  final String categoryId; // Now required
  final DateTime createdAt; // Now required

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.completed,
    required this.userId,
    required this.categoryId,
    required this.createdAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['\$id'],
      title: json['title'] ?? 'بدون عنوان',
      description: json['description'],
      completed: json['completed'] ?? false,
      userId: json['userId'] ?? '',
      categoryId:
          json['categoryId'] ??
          '', // Fallback to empty string if null (adjust as needed)
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
      'userId': userId,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
