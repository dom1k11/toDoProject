import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/buttons/custom_floating_action_button.dart';
import 'package:to_do_app_practice_2/widgets/custom_date_text_field.dart';
import 'package:to_do_app_practice_2/widgets/custom_text_field.dart';

import 'package:to_do_app_practice_2/widgets/dropdown_block.dart';
import 'package:to_do_app_practice_2/services/task_service.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

String selectedPriority = 'Low'; // Значение по умолчанию

TextEditingController newTaskNameController = TextEditingController();
TextEditingController newTaskDescriptionController = TextEditingController();
TextEditingController newTaskDateTimeController = TextEditingController();

class _NewTaskPageState extends State<NewTaskPage> {
  void initState() {
    super.initState();
    // Устанавливаем текущую дату в контроллер в нужном формате
    newTaskDateTimeController.text =
        DateFormat('MMM d, yyyy').format(DateTime.now().add(Duration(days: 7)));
  }

  void resetPriority() {
    setState(() {
      selectedPriority =
          'Default'; // Сброс значения приоритета на значение по умолчанию
    });
  }

  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          _buildTaskNameTextField(),
          _buildDescriptionTextField(),
          _buildCustomDateTextField(context),
          // buildDateContainer(),
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
            addTask(
                context, resetPriority); // Передаем контекст и функцию сброса
          },
          color: Colors.greenAccent, // Задайте нужный цвет
          icon: Icons.edit, labelText: "Add New Task", // Задайте нужную иконку
        ),
      ),
    );
  }

  CustomDateTextField _buildCustomDateTextField(BuildContext context) {
    return CustomDateTextField(
          controller: newTaskDateTimeController,
          context: context, // Передаем контекст для выбора даты
          hintText: "Deadline",
        );
  }

  CustomTextField _buildTaskNameTextField() {
    return CustomTextField(
      controller: newTaskNameController,
      hintText: "",
      prefixIcon: Icons.task,
      labelText: "Task Name",
      maxLines: 1,
    );
  }

  CustomTextField _buildDescriptionTextField() {
    return CustomTextField(
      controller: newTaskDescriptionController,
      hintText: "",
      prefixIcon: Icons.description_outlined,
      labelText: "Description",
      maxLines: 2,
    );
  }


}
