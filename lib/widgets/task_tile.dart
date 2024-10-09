import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:to_do_app_practice_2/models/task.dart';
import 'package:to_do_app_practice_2/services/task_service.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/widgets/snack_bar.dart';

import '../utils/task_helpers.dart';

class TaskTileWidget extends StatefulWidget {
  TaskTileWidget({required this.oneTask})
      : super(key: Key(oneTask.id)); // Уникальный ключ

  final Task oneTask;

  @override
  State<TaskTileWidget> createState() => _TaskTileWidgetState();
}

class _TaskTileWidgetState extends State<TaskTileWidget> {
  bool _visible = true;

  @override
  Widget build(BuildContext) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 500),
      onEnd: () {
        if (!_visible) {
          deleteTask(widget.oneTask.id);
        }
      },
      child: Container(
        // margin: const EdgeInsets.only(top: 2, bottom: 2),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                onPressed: (context) {
                  newTaskSnackBar(context, "Task Deleted", Colors.redAccent);
                  setState(() {
                    _visible = false;
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
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                      // top: BorderSide(width: 2.0, color: Colors.grey.shade800),
                      bottom:
                          BorderSide(width: 2.0, color: Colors.grey.shade800)),
                  color: Color.fromARGB(255, 53, 53, 53),
                ),
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: ListTile(
                  leading: IconButton(
                      onPressed: () {
                        setCompleted(
                            widget.oneTask.id, widget.oneTask.isCompleted);
                      },
                      icon: Icon(Icons.check_box_outline_blank_outlined)),
                  title: Row(
                    children: [
                      Text(
                        widget.oneTask.taskName,
                        style: const TextStyle(color: Colors.orange),
                      ),
                      const SizedBox(width: 5),
                      getPriorityIcon(widget.oneTask.priority),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.oneTask.taskDescription,
                        style: const TextStyle(color: Colors.orangeAccent),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat('MMM d, yyyy').format(widget
                            .oneTask.dateTime), // Форматируем для отображения
                        style: const TextStyle(color: Colors.orangeAccent),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_left),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
