import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dark mode check
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Overview"),
        elevation: 0,
        backgroundColor: Colors.transparent, // Fix: White color hata diya
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          final tasks = provider.tasks;

          final totalTasks = tasks.length;
          final completedTasks = tasks.where((t) => t.isCompleted).length;
          final pendingTasks = totalTasks - completedTasks;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your Progress",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black, // Fix
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    _buildStatCard(
                      "Total",
                      totalTasks.toString(),
                      Colors.blue,
                      isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      "Done",
                      completedTasks.toString(),
                      Colors.green,
                      isDark,
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      "Pending",
                      pendingTasks.toString(),
                      Colors.orange,
                      isDark,
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.grey[800]
                        : Colors.purple.withOpacity(0.1), // Fix
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.insights,
                        color: isDark ? Colors.purpleAccent : Colors.purple,
                        size: 32,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          completedTasks == totalTasks && totalTasks > 0
                              ? "Excellent! You have completed all your tasks."
                              : "Keep going! You have $pendingTasks tasks left to complete.",
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark
                                ? Colors.white70
                                : Colors.black87, // Fix
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String title, String count, Color color, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[800] : color.withOpacity(0.1), // Fix
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? color.withOpacity(0.5) : color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? color.withOpacity(0.9) : color,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.grey[400] : Colors.black54, // Fix
              ),
            ),
          ],
        ),
      ),
    );
  }
}
