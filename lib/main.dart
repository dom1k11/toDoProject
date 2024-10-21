import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_app_practice_2/screens/done_task_screen.dart';
import 'package:to_do_app_practice_2/screens/edit_task_screen.dart';
import 'package:to_do_app_practice_2/screens/new_task_screen.dart';
import 'package:to_do_app_practice_2/screens/tasks_screen.dart';
import 'package:to_do_app_practice_2/screens/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDyEvFXNWRJQEmR6_2WEmU5VLI8eDnhsLo",
        appId: "1:851447533851:web:9167f28bf81ec9aa6683be",
        messagingSenderId: "851447533851",
        projectId: "to-do-project-d68df"),
  );
  print("Firebase успешно инициализирован");

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }

  runApp(MyApp(isFirstLaunch: isFirstLaunch));
}

class MyApp extends StatelessWidget {
  final bool isFirstLaunch;

  const MyApp({Key? key, required this.isFirstLaunch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 208, 188, 213)),
          bodySmall: TextStyle(color: Color.fromARGB(255, 255, 231, 76)),
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 53, 53, 53),
      ),
      home: isFirstLaunch ? WelcomePage() : const TasksPage(),
      //home : WelcomePage(),
      initialRoute: '/',
      routes: {
        '/tasks_page': (context) => const TasksPage(),
        '/new_task_screen': (context) => const NewTaskPage(),
        '/edit_task_screen': (context) => const EditTaskPage(),
        '/done_task_screen': (context) => const DoneTaskScreen(),
        '/welcome_page': (context) => WelcomePage(),
      },
    );
  }
}
