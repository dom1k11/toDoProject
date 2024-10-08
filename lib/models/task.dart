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
}

