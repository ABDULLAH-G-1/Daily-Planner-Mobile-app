import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart'; // Naya import
import 'splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  await Hive.openBox<Task>('tasks');
  await Hive.openBox(
    'settings',
  ); // Theme save karne ke liye settings box open kiya

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ), // Theme Provider add kiya
      ],
      child: const SmartTaskManager(),
    ),
  );
}

class SmartTaskManager extends StatelessWidget {
  const SmartTaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    // Consumer use kiya taake theme change hotay hi poori app update ho jaye
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Daily Planner',

          // Light Theme Settings
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.grey[100],
          ),

          // Dark Theme Settings
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.dark,
          ),

          // Jo theme provider mein set hai wo apply hogi
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
