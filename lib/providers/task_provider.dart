import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  Box<Task>? _taskBox;
  String _searchQuery = '';

  TaskProvider() {
    _init();
  }

  // Database Access
  Future<void> _init() async {
    if (Hive.isBoxOpen('tasks')) {
      _taskBox = Hive.box<Task>('tasks');
    } else {
      _taskBox = await Hive.openBox<Task>('tasks');
    }
    notifyListeners();
  }

  // 1. Get All Tasks
  List<Task> get tasks {
    if (_taskBox == null) return [];

    // List all tasks
    final allTasks = _taskBox!.values.toList();

    // Sort tasks (Newest First)
    allTasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Search Logic
    if (_searchQuery.isEmpty) {
      return allTasks;
    } else {
      return allTasks.where((task) {
        final query = _searchQuery.toLowerCase();
        return task.title.toLowerCase().contains(query) ||
            task.description.toLowerCase().contains(query) ||
            task.category.toLowerCase().contains(query); // Category search (Bonus)
      }).toList();
    }
  }

  // 2. Add Task (Updated with Category & DueDate)
  Future<void> addTask(String title, String desc, String priority, String category, DateTime? dueDate) async {
    final newTask = Task(
      title: title,
      description: desc,
      priority: priority,
      createdAt: DateTime.now(),
      isCompleted: false,
      category: category,
      dueDate: dueDate,
    );
    await _taskBox?.add(newTask);
    notifyListeners();
  }

  // 3. Delete Task
  Future<void> deleteTask(Task task) async {
    await task.delete();
    notifyListeners();
  }

  // 4. Update Task Details (Updated with Category & DueDate)
  Future<void> updateTask(Task task, String newTitle, String newDesc, String newPriority, String newCategory, DateTime? newDate) async {
    task.title = newTitle;
    task.description = newDesc;
    task.priority = newPriority;
    task.category = newCategory;
    task.dueDate = newDate;

    await task.save();
    notifyListeners();
  }

  // 5. Update Status (Tick mark)
  Future<void> toggleTaskStatus(Task task) async {
    task.isCompleted = !task.isCompleted;
    await task.save();
    notifyListeners();
  }

  // 6. Search Function
  void searchTasks(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}