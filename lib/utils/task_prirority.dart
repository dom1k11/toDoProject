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

int priorityValue(String priority) {
  switch (priority) {
    case 'High':
      return 3; // Высокий приоритет
    case 'Medium':
      return 2; // Средний приоритет
    case 'Low':
      return 1; // Низкий приоритет
    default:
      return 0; // По умолчанию
  }
}


Icon getPriorityIcon(String priority) {
  switch (priority) {
    case 'High':
      return const Icon(Icons.warning, color: Colors.red, size: 36);
    case 'Medium':
      return const Icon(Icons.info, color: Colors.yellow, size: 36);
    case 'Low':
      return const Icon(Icons.flag_circle, color: Colors.green, size: 36);
    case 'Default':
      return const Icon(Icons.help, color: Colors.grey, size: 36); // Иконка по умолчанию
    default:
      return const Icon(Icons.help, color: Colors.black, size: 36); // Иконка по умолчанию
  }
}

Color getPriorityColor(String priority) {
  switch (priority) {
    case 'High':
      return Color.fromARGB(255, 238, 126, 118); // Красный для высокого приоритета
    case 'Medium':
      return Color.fromARGB(200, 255, 233, 125); // Желтый для среднего приоритета
    case 'Low':
      return Color.fromARGB(255, 127, 238, 175); // Зеленый для низкого приоритета
    case 'Default':
      return Colors.grey; // Серый для приоритета по умолчанию
    default:
      return Colors.black; // Черный по умолчанию
  }
}