import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onStatusChanged;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onStatusChanged,
    required this.onDelete,
  });

  // Date format karne ka helper
  String _formatDate(DateTime? date) {
    if (date == null) return "No Date";
    return "${date.day}/${date.month}"; // e.g., 12/8
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        // Leading: Checkbox
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (val) => onStatusChanged(),
          activeColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),

        // Title
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            color: task.isCompleted ? Colors.grey : Colors.black87,
          ),
        ),

        // Subtitle: Category, Date, aur Priority
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Category aur Date Row
            Row(
              children: [
                Icon(Icons.category, size: 14, color: Colors.purple[400]),
                const SizedBox(width: 4),
                Text(
                  task.category,
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),

                const SizedBox(width: 16), // Spacing

                Icon(Icons.calendar_today, size: 14, color: Colors.blue[400]),
                const SizedBox(width: 4),
                Text(
                  _formatDate(task.dueDate),
                  style: TextStyle(color: Colors.grey[700], fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Priority Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getPriorityColor(task.priority).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getPriorityColor(task.priority),
                  width: 1,
                ),
              ),
              child: Text(
                task.priority,
                style: TextStyle(
                  fontSize: 12,
                  color: _getPriorityColor(task.priority),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),

        // Trailing: Delete Icon
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
          onPressed: onDelete,
        ),
      ),
    );
  }

  // Helper function priority color ke liye
  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
