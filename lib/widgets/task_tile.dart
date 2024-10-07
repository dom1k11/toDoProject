import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/models/task.dart';
import 'package:to_do_app_practice_2/services/task_service.dart';

import '../screens/home_screen.dart';
import '../utils/task_helpers.dart';

class TaskTileWidget extends StatelessWidget {
  const TaskTileWidget({super.key, required this.oneTask});

  final Task oneTask;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 2),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (context) {
                deleteTask(oneTask.id);
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (context) { Navigator.pushNamed(context, '/edit_task_screen');},
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
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              color: const Color.fromARGB(255, 255, 231, 76),
              child: ListTile(
                leading: const Icon(Icons.check_box_outline_blank_outlined),
                title: Row(
                  children: [
                    getPriorityIcon(oneTask.priority),
                    SizedBox(width: 5),
                    Text(oneTask.taskName),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(oneTask.taskDescription),
                   // Text(DateFormat('dd MMMM yyyy').format(oneTask.dateTime))
                  ],
                ),
                trailing: const Icon(Icons.arrow_left),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
