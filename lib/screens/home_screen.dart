import 'package:flutter/material.dart';
import 'package:to_do_app_practice_2/models/task.dart';
import 'package:to_do_app_practice_2/services/task_service.dart';
import 'package:to_do_app_practice_2/widgets/search_block.dart';
import 'package:to_do_app_practice_2/widgets/task_tile.dart';

import '../buttons/custom_floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: const SearchBlockWidget(), //Виджет Поиска
          ),
          const Text(
            "Pending Tasks",
            style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 208, 188, 213),
            ),
          ),
          const Divider(),
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: getTasks(), // Асинхронная операция
              builder:
                  (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
                // Логика отображения в зависимости от состояния snapshot
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child:
                      CircularProgressIndicator()); // Показать индикатор загрузки
                } else if (snapshot.hasError) {
                  return Center(
                      child:
                      Text('Ошибка: ${snapshot.error}')); // Показать ошибку
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Нет данных.')); // Сообщение, если данных нет
                }

                // Если данные успешно получены, отобразить их в ListView
                List<Task> tasks = snapshot.data!;
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
          )
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_task_screen');
        },
        color: Colors.yellow, // Задайте нужный цвет
        icon: Icons.add, // Задайте нужный иконку
      ),
    );
  }
}