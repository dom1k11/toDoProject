import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/snack_bar.dart';
import '../models/task.dart';
import '../screens/new_task_screen.dart';

Future<void> addTask(BuildContext context) async {
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
          DateFormat.yMd().parse(newTaskDateTimeController.text),
        ),
      });

      print("Task sucessfully added");

      newTaskNameController.clear();
      newTaskDescriptionController.clear();
      newTaskDateTimeController.clear();
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
        taskName: doc['task_name'],
        // Используй данные из Firestore
        taskDescription: doc['task_description'],
        // Используй данные из Firestore
        dateTime: (doc['DateTime'] as Timestamp).toDate(),
        // Преобразование Timestamp в DateTime
        // Преобразование строки даты в объект DateTime
        // Преобразуй временную метку
        priority: doc['priority'],
        id: doc.id,
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
