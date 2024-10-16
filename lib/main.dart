import 'package:flutter/material.dart';
import 'package:to_do_app_practice_2/screens/done_task_screen.dart';
import 'package:to_do_app_practice_2/screens/edit_task_screen.dart';
import 'package:to_do_app_practice_2/screens/new_task_screen.dart';
import '../screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Основной цвет приложения
        hintColor: Colors.orange,
        // Акцентный цвет (например, для FloatingActionButton)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orangeAccent, // Цвет AppBar
          centerTitle: true,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orange, // Цвет FloatingActionButton
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color.fromARGB(255, 208, 188, 213)),
          // Цвет для bodyLarge текста
          // bodyMedium: TextStyle(color: Color.fromARGB(255, 208, 188, 213)),
          // Цвет для bodyMedium текста
          bodySmall: TextStyle(
              color: Color.fromARGB(
                  255, 255, 231, 76)), // Цвет для bodySmall текста
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 53, 53, 53),
      ),
      home: const HomePage(),
      initialRoute: '/',
      routes: {
        // '/': (context) => const HomePage(),
        // '/new_task_screen': (context) => const NewTaskPage(),
        '/edit_task_screen': (context) => const EditTaskPage(),
        '/done_task_screen': (context) => const DoneTaskScreen(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/new_task_screen':
            return PageTransition(
              child: const NewTaskPage(),
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 300), // Установи нужную продолжительность анимации
               curve: Curves.easeOutSine, // Установи нужную кривую анимации
            );
          default:
            return null; // Если маршрут не найден, вернем null
        }
      },
    );
  }
}
