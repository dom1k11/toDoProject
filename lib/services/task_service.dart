import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_practice_2/screens/home_screen.dart';

import '../models/task.dart';

Future<void> addTask() async {
  try {
    await FirebaseFirestore.instance.collection('toDoTasks').add({
      'task_name': 'Sleeping',
      'task_description': '8 hours',
      'isCompleted': 'true',
      'priority': 'Low',
      'DateTime': '2024/07/10',
    });

    print("Task sucessfully added");
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
        //  dateTime: (doc['date_time'] as String), // Преобразуй временную метку
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