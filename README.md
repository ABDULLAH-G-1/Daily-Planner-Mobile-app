# Daily Planner Mobile App 📝

A robust, responsive, and highly efficient task management application built using Flutter. This app allows users to organize their daily routines, track pending work, and manage priorities with a seamless user experience. Developed as part of the IT Solera Mobile App Development challenge (Task 2).

## ✨ Key Features

### Core Functionalities
* **CRUD Operations:** Easily Create, Read, Update, and Delete tasks.
* **Smart Validation:** Prevents empty submissions with user-friendly error handling.
* **Persistent Storage:** Data is saved locally using Hive NoSQL database, ensuring tasks remain intact even after the app is completely closed.

### Advanced & Bonus Features 🚀
* **Categorization & Due Dates:** Assign tasks to specific categories (Work, Personal, Study) and set precise due dates using a native calendar picker.
* **Real-time Search:** Instantly filter tasks by title, description, or category using the dynamic search bar.
* **Interactive Dashboard:** A built-in statistics screen that calculates and displays Total, Completed, and Pending tasks in real-time.
* **Dynamic Dark Mode:** A complete, system-independent Light/Dark mode toggle that persists across app restarts.

## 🛠️ Tech Stack
* **Framework:** Flutter / Dart
* **State Management:** Provider
* **Local Database:** Hive (Fast, lightweight NoSQL database)
* **Architecture:** Component-based UI with separated business logic

## 📂 Project Structure
```text
lib/
 ├── models/          # Hive data models (task.dart, task.g.dart)
 ├── providers/       # State management logic (task_provider.dart, theme_provider.dart)
 ├── screens/         # UI Screens (home, add_task, task_details, stats, splash)
 ├── widgets/         # Reusable UI components (task_tile.dart)
 └── main.dart        # Entry point and theme configuration
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
