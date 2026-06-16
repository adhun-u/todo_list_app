class TodoModel {
  final int id;
  final String title;
  final String? subtitle;
  final DateTime createdAt;
  final bool isCompleted;
  final DateTime whenToComplete;

  TodoModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAt,
    required this.isCompleted,
    required this.whenToComplete,
  });

  TodoModel copyWith({
    int? id,
    String? title,
    String? subtitle,
    DateTime? createdAt,
    bool? isCompleted,
    DateTime? whenToComplete,
  }) {
    return TodoModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
      whenToComplete: whenToComplete ?? this.whenToComplete,
      id: id ?? this.id,
    );
  }
}
