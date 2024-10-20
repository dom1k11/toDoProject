import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app_practice_2/models/task.dart';
import 'package:to_do_app_practice_2/utils/task_prirority.dart';
import 'package:to_do_app_practice_2/widgets/drawer.dart';
import 'package:to_do_app_practice_2/widgets/search_block.dart';
import 'package:to_do_app_practice_2/widgets/task_tile.dart';

import '../buttons/custom_floating_action_button.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(255, 70, 70, 70),
            ),
            child: SearchBlockWidget(), //Виджет Поиска
          ),
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
                List<Task> tasks = docs
                    .map((doc) {
                      return Task(
                        id: doc.id,
                        taskName: doc['task_name'],
                        taskDescription: doc['task_description'],
                        dateTime: (doc['DateTime'] as Timestamp).toDate(),
                        priority: doc['priority'],
                        isCompleted: doc[
                            'isCompleted'], // Используем правильное название поля
                      );
                    })
                    .where((task) => !task.isCompleted)
                    .toList(); // Фильтрация невыполненных задач

                // Сортируем список задач по приоритету
                tasks.sort((a, b) => priorityValue(b.priority)
                    .compareTo(priorityValue(a.priority)));

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskTileWidget(
                      oneTask: tasks[index],
                      showTrailing:
                          true, // Передаем каждую задачу в TaskTileWidget
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_task_screen');
        },
        color: Colors.deepOrangeAccent, // Задайте нужный цвет
        icon: Icons.edit_calendar,
        labelText: "New Task?",
      ),
    );
  }
}
