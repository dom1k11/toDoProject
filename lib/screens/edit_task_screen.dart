import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/buttons/custom_floating_action_button.dart';
import 'package:to_do_app_practice_2/screens/new_task_screen.dart';
import 'package:to_do_app_practice_2/services/task_service.dart';
import 'package:to_do_app_practice_2/widgets/custom_date_text_field.dart';
import 'package:to_do_app_practice_2/widgets/custom_text_field.dart';
import 'package:to_do_app_practice_2/widgets/dropdown_block.dart';

import '../models/task.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

TextEditingController editTaskNameController = TextEditingController();
TextEditingController editTaskDescriptionController = TextEditingController();
TextEditingController editTaskDateController = TextEditingController();

class _EditTaskPageState extends State<EditTaskPage> {
  @override

  late Task task;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments;

    if (arguments is Task) {
      task = arguments;
      // Заполняем контроллеры
      editTaskNameController.text = task.taskName;
      editTaskDescriptionController.text = task.taskDescription;
      editTaskDateController.text = DateFormat('MMM d, yyyy').format(task.dateTime);
      selectedPriority = task.priority; // Дополнительно сохраняем приоритет
    }
  }

  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          CustomTextField(
              controller: editTaskNameController,
              hintText: "",
              prefixIcon: Icons.task,
              labelText: "Edit Task",
              maxLines: 1),
          CustomTextField(
            controller: editTaskDescriptionController,
            hintText: "",
            prefixIcon: Icons.description_outlined,
            labelText: "Description",
            maxLines: 2,
          ),
          CustomDateTextField(
            controller: editTaskDateController,
            context: context, // Передаем контекст для выбора даты
            hintText: "Deadline",
          ),
          DropdownMenuBlock(
            onPrioritySelected: (priority) {
              setState(() {
                selectedPriority = priority; // Сохраняем выбранный приоритет
              });
            },
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: !showFab,
        child: CustomFloatingActionButton(
          onPressed: () {
            editTask(task.id); // Здесь передаём идентификатор задачи
           Navigator.pop(context); // Закрыть экран после редактирования
          },
          color: Colors.blueAccent,
          icon: Icons.edit,
          labelText: "Edit Task",
        ),

      ),
    );
  }
}
