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
  bool _visible = true;
  bool _completed = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      onEnd: () {
        if (!_visible) {
          deleteTask(
              widget.oneTask.id); // Удаляем задачу после анимации скрытия
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
          child: Slidable(
            enabled: !widget.oneTask.isCompleted,
            // Отключаем Slidable для выполненных задач
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

                  setState(() {
                    widget.oneTask.isCompleted = !currentStatus;
                  });

                  await Future.delayed(const Duration(milliseconds: 400));

                  await setCompleted(widget.oneTask.id, currentStatus);
                },
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    widget.oneTask.isCompleted
                        ? Icons.check_box // Выполненная задача
                        : Icons.check_box_outline_blank, // Невыполненная задача
                    key: ValueKey<bool>(
                        widget.oneTask.isCompleted), // Добавляем ключ
                  ),
                ),
              ),
              title: _buildTaskText(widget.oneTask.taskName),
              subtitle: _buildSubtitle(),
              trailing: _buildTrailing(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskText(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        decoration: widget.oneTask.isCompleted
            ? TextDecoration.lineThrough // Зачеркнутая выполненная задача
            : TextDecoration.none,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTaskText(widget.oneTask.taskDescription),
        const SizedBox(height: 5),
        Row(
          children: [
            _buildTaskText(
                DateFormat('MMM d, yyyy').format(widget.oneTask.dateTime)),
            const SizedBox(width: 10),
            Text(
              widget.oneTask.isCompleted ? "" : widget.oneTask.daysLeft,
              style: TextStyle(
                color: widget.oneTask.daysLeftColor,
                shadows: const [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 1.0,
                  ),
                ],
                fontSize: 14,
                decoration: widget.oneTask.isCompleted
                    ? TextDecoration
                        .lineThrough // Зачеркнуть выполненную задачу
                    : TextDecoration.none,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrailing() {
    return widget.oneTask.isCompleted
        ? const Text("")
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              getPriorityIcon(widget.oneTask.priority),
              const SizedBox(width: 20),
              const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black),
            ],
          );
  }
}
