import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/screens/edit_task_screen.dart';
import '../widgets/snack_bar.dart';
import '../models/task.dart';
import '../screens/new_task_screen.dart';

Future<void> addTask(BuildContext context, Function resetPriority) async {
  try {
    if (newTaskNameController.text.isNotEmpty) {
      String taskDescription = newTaskDescriptionController.text.isNotEmpty
          ? newTaskDescriptionController.text
          : "No Description"; // Если пусто, используем "No Description"

      await FirebaseFirestore.instance.collection('toDoTasks').add({
        'task_name': newTaskNameController.text,
        'task_description': taskDescription,
        'isCompleted': false,
        'priority': selectedPriority,
        'DateTime': Timestamp.fromDate(
          DateFormat('MMM d, yyyy').parse(newTaskDateTimeController.text),
        ),
      });

      print("Task successfully added");

      // Очищаем поля ввода
      newTaskNameController.clear();
      newTaskDescriptionController.clear();
      newTaskDateTimeController.clear();
      // Сбрасываем выбранный приоритет
      resetPriority(); // Вызов функции сброса

      Navigator.pop(context);
      newTaskSnackBar(context, "New Task Added", Colors.greenAccent);
    } else {
      print("can't add, Empty task Name");
      newTaskSnackBar(context, "Task Name Required", Colors.redAccent);
    }
  } catch (e) {
    print("Error adding data $e");
  }
}

Future<List<Task>> getTasks() async {
  List<Task> taskList = [];

  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('toDoTasks').get();
    for (var doc in querySnapshot.docs) {
      taskList.add(Task(
        id: doc.id,
        taskName: doc['task_name'],
        taskDescription: doc['task_description'],
        dateTime: (doc['DateTime'] as Timestamp).toDate(),
        // Преобразуем Timestamp в DateTime
        priority: doc['priority'],
      ));
    }
  } catch (e) {
    print("Error getting data $e");
  }
  return taskList;
}

Future<void> deleteTask(String taskId) async {
  try {
    await FirebaseFirestore.instance
        .collection('toDoTasks')
        .doc(taskId)
        .delete();
    print("Task Deleted Successfully");
  } catch (e) {
    print("Error deleting task: $e");
  }
}

Future<void> setCompleted(String taskId, bool currentStatus) async {
  try {
    print(
        "Updating task ID: $taskId from status: $currentStatus"); // Отладочное сообщение
    await FirebaseFirestore.instance
        .collection('toDoTasks')
        .doc(taskId)
        .update({'isCompleted': !currentStatus}); // Переключение статуса
    print("Task status updated successfully.");
    print("Task id $taskId");
    print("Task status $currentStatus");
  } catch (e) {
    print("Error updating task status: $e");
  }
}

Future<void> editTask(String taskId) async {
  if (taskId.isEmpty) {
    print("Invalid task ID: $taskId");
    return;
  }

  try {
    print("Updating task data: $taskId");
    await FirebaseFirestore.instance.collection("toDoTasks").doc(taskId).update(
      {
        'task_name': editTaskNameController.text,
        'task_description': editTaskDescriptionController.text,
        'DateTime': DateFormat('MMM d, yyyy').parse(editTaskDateController.text),
        'priority': selectedPriority,
      },
    );
    print("Task updated successfully.");
  } catch (e) {
    print("Error updating task data: $e");
  }
}

