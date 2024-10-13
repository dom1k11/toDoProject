import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app_practice_2/models/task.dart';
import 'package:to_do_app_practice_2/services/task_service.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/widgets/snack_bar.dart';
import '../utils/task_prirority.dart';

class TaskTileWidget extends StatefulWidget {
  final Task oneTask;

  TaskTileWidget({required this.oneTask, Key? key})
      : super(key: Key(oneTask.id));

  @override
  State<TaskTileWidget> createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  bool _visible = true; // Управление видимостью для анимации удаления

  // Метод для получения цвета приоритета

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      onEnd: () {
        if (!_visible) {
          // Удаляем задачу после анимации скрытия
          deleteTask(widget.oneTask.id);
        }
      },
      child: Container(
        color: const Color.fromARGB(255, 60, 60, 60),
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: getPriorityColor(widget.oneTask.priority),
          ),
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    newTaskSnackBar(context, "Task Deleted", Colors.redAccent);
                    setState(() {
                      _visible = false; // Скрываем задачу с анимацией
                    });
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context) {
                    Navigator.pushNamed(context, '/edit_task_screen');
                  },
                  backgroundColor: const Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.edit_note,
                  label: 'Edit',
                ),
              ],
            ),
            child: ListTile(
              leading: IconButton(
                onPressed: () async {
                  bool currentStatus = widget.oneTask.isCompleted;
                  await setCompleted(widget.oneTask.id, currentStatus);

                  setState(() {
                    widget.oneTask.isCompleted =
                        !currentStatus; // Меняем статус задачи
                  });
                },
                icon: Icon(
                  widget.oneTask.isCompleted
                      ? Icons.check_box // Выполненная задача
                      : Icons.check_box_outline_blank, // Невыполненная задача
                ),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.oneTask.taskName,
                      style: TextStyle(
                        color: Colors.black,
                        decoration: widget.oneTask.isCompleted
                            ? TextDecoration
                                .lineThrough // Зачеркнуть выполненную задачу
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  // Иконка приоритета
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.oneTask.taskDescription,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        DateFormat('MMM d, yyyy')
                            .format(widget.oneTask.dateTime),
                        // Дата задачи
                        style: const TextStyle(color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      // Используем метод daysLeft для отображения оставшихся дней
                      Text(
                        "${widget.oneTask.daysLeft}",
                        // Отображаем строку с количеством дней
                        style: TextStyle(
                            color: widget.oneTask.daysLeftColor,
                            shadows: const [
                              Shadow(
                                color: Colors.black,
                                // Цвет тени
                                offset: Offset(1.0, 1.0),
                                // Смещение тени
                                blurRadius: 1.0,
                              ), // Радиус размытия тени)
                            ],
                            fontSize: 14 // Применяем цвет текста
                            ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                // Минимальный размер для трейлинга
                children: [
                  getPriorityIcon(widget.oneTask.priority),
                  const SizedBox(width: 20),
                  const Icon(Icons.arrow_back_ios_new_sharp,
                      color: Colors.orange),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
