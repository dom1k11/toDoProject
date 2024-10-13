import 'package:flutter/material.dart';

class Task {
  String id;
  String taskName;
  String taskDescription;
  bool isCompleted;
  String priority;
  DateTime dateTime;

  Task({
    required this.id,
    required this.taskName,
    this.taskDescription = "No Description",
    required this.dateTime,
    required this.priority,
    this.isCompleted = false,
  });


  String get daysLeft {
    final DateTime now = DateTime.now();
    final DateTime endOfTaskDate = DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
    final Duration difference = endOfTaskDate.difference(now);

    if (difference.inDays > 0) {
      return '${difference.inDays} days left';
    } else if (difference.inDays == 0) {
      return 'Last Day';
    } else {
      return '${difference.inDays.abs()} days ago';
    }
  }


  Color get daysLeftColor {
    final DateTime now = DateTime.now();
    final DateTime endOfTaskDate = DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);
    final Duration difference = endOfTaskDate.difference(now);

    if (difference.inDays > 2) {
      return Colors.green; // Более 2 дней — зеленый
    } else if (difference.inDays == 2) {
      return Colors.yellow; // 2 дня — желтый
    } else if (difference.inDays == 1) {
      return Colors.orange; // 1 день — оранжевый
    } else {
      return Colors.red; // Менее 1 дня — красный
    }
  }
}
