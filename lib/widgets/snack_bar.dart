import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void newTaskSnackBar(BuildContext context, String message, Color color) {
  final newTaskSnackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.black),
    ),
    duration: const Duration(seconds: 2),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(newTaskSnackBar);
}
