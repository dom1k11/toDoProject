import 'package:flutter/material.dart';

Icon getPriorityIcon(String priority) {
  switch (priority) {
    case 'High':
      return const Icon(Icons.warning,
          color: Colors.red); // Иконка для высокого приоритета
    case 'Medium':
      return const Icon(Icons.info,
          color: Colors.orange); // Иконка для среднего приоритета
    case 'Low':
      return const Icon(Icons.flag_circle,
          color: Colors.green); // Иконка для низкого приоритета
    default:
      return const Icon(Icons.help, color: Colors.black); // Иконка по умолчанию
  }
}