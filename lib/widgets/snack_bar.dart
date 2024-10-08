import 'package:flutter/material.dart';

class TaskAddedSnackBar extends StatelessWidget {
  const TaskAddedSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void newTaskSnackBar(BuildContext context, String message, Color color) {
  final newTaskSnackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.black),
    ),
    duration: Duration(seconds: 2),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(newTaskSnackBar);
}
