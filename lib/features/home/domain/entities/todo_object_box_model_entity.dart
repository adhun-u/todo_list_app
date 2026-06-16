import 'package:objectbox/objectbox.dart';

@Entity()
class TodoObjectBoxModelEntity {
  @Id()
  int id = 0;
  String title;
  String? subtitle;
  String whenToComplete;
  bool isCompleted;
  String createdAt;
  TodoObjectBoxModelEntity({
    this.id = 0,
    required this.title,
    this.subtitle,
    required this.whenToComplete,
    required this.isCompleted,
    required this.createdAt,
  });
}
