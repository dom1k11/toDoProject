import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_practice_2/models/task.dart';
import 'package:to_do_app_practice_2/utils/task_prirority.dart';
import 'package:to_do_app_practice_2/widgets/task_tile.dart';

class DoneTaskScreen extends StatelessWidget {
  const DoneTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Done Tasks'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(
            color: Colors.grey.shade800,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('toDoTasks')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  ); // Показать индикатор загрузки
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Ошибка: ${snapshot.error}'),
                  ); // Показать ошибку
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      'You do not have any tasks, try to add a new one?',
                      style: TextStyle(color: Colors.orange),
                    ),
                  ); // Сообщение, если данных нет
                }
                // Получаем список документов из snapshot
                List<DocumentSnapshot> docs = snapshot.data!.docs;
                // Преобразуем документы в список задач
                List<Task> tasks = docs.map((doc) {
                  return Task(
                    id: doc.id,
                    taskName: doc['task_name'],
                    taskDescription: doc['task_description'],
                    dateTime: (doc['DateTime'] as Timestamp).toDate(),
                    priority: doc['priority'],
                    isCompleted: doc['isCompleted'], // Используем правильное название поля
                  );
                }).where((task) => task.isCompleted).toList(); // Фильтрация невыполненных задач
                // Сортируем список задач по приоритету
                tasks.sort((a, b) => priorityValue(b.priority)
                    .compareTo(priorityValue(a.priority)));

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskTileWidget(
                      oneTask: tasks[
                      index], // Передаем каждую задачу в TaskTileWidget
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}
