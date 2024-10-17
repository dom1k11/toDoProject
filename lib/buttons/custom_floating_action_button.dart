import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.icon, required this.labelText});

  final VoidCallback onPressed;
  final Color color;
  final IconData icon;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      backgroundColor: color,
      icon: Icon(icon), // Иконка
      label: Text(labelText), // Текст
    );
  }
}
