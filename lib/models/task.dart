import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  String priority;

  // --- NEW FEATURES FOR TASK 2 ---
  @HiveField(5)
  String category;    // e.g., Work, Personal, Study

  @HiveField(6)
  DateTime? dueDate;  // Optional deadline

  Task({
    required this.title,
    this.description = '',
    this.isCompleted = false,
    required this.createdAt,
    this.priority = 'Low',
    this.category = 'General', // Default category
    this.dueDate,
  });
}