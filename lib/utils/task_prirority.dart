import 'package:flutter/material.dart';

class Priority {
  final String name;
  final Color color;
  final IconData icon; // Добавляем поле для иконки

  Priority(this.name, this.color, this.icon); // Обновляем конструктор
}

final List<Priority> dropdownList = [
  Priority('Default', Colors.grey, Icons.help), // Добавляем значение по умолчанию
  Priority('High', Colors.red, Icons.warning),
  Priority('Medium', Colors.yellow, Icons.info),
  Priority('Low', Colors.green, Icons.flag_circle),
];

Icon getPriorityIcon(String priority) {
  switch (priority) {
    case 'High':
      return const Icon(Icons.warning, color: Colors.red);
    case 'Medium':
      return const Icon(Icons.info, color: Colors.yellow);
    case 'Low':
      return const Icon(Icons.flag_circle, color: Colors.green);
    case 'Default':
      return const Icon(Icons.help, color: Colors.grey); // Иконка по умолчанию
    default:
      return const Icon(Icons.help, color: Colors.black); // Иконка по умолчанию
  }
}