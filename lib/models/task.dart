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

  // Метод для вычисления оставшихся дней до выполнения задачи
  int get daysLeft {
    final DateTime now = DateTime.now();
    // Устанавливаем время на 23:59:59 для учета полного дня
    final DateTime endOfTaskDate = DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59);

    // Вычисляем разницу
    final Duration difference = endOfTaskDate.difference(now);

    // Возвращаем оставшиеся дни, если они больше нуля
    return difference.inDays >= 0 ? difference.inDays : 0;
  }
}
