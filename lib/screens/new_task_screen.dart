import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/buttons/custom_floating_action_button.dart';

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
    newTaskDateTimeController.text = DateFormat.yMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Column(
        children: [
          buildTaskNameContainer(),
          buildTaskDescriptionContainer(),
          buildDateContainer(),
          DropdownMenuBlock(
            onPrioritySelected: (priority) {
              setState(() {
                selectedPriority = priority; // Сохраняем выбранный приоритет
              });
            },
          ),
        ],
      ),
      floatingActionButton:  CustomFloatingActionButton(
        onPressed: () => addTask(context),
        color: Colors.greenAccent, // Задайте нужный цвет
        icon: Icons.add, // Задайте нужный иконку
      ),
    );
  }

  Container buildDateContainer() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 70, 70, 70),
      ),
      child: TextField(
        controller: newTaskDateTimeController,
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2024, 1, 1),
              maxTime: DateTime(2026, 12, 31), onChanged: (date) {
            print('change $date');
          }, onConfirm: (date) {
            setState(() {
              newTaskDateTimeController.text = DateFormat.yMd().format(date);
            });

            print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        readOnly: true,
        decoration: const InputDecoration(
          label: Text(
            "Deadline",
            style: TextStyle(color: Colors.orange),
          ),
          prefixIcon: Icon(
            Icons.date_range_outlined,
            color: Colors.orange,
          ),
          border: InputBorder.none,
          hintText: "Date",
        ),
      ),
    );
  }

  Container buildTaskDescriptionContainer() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 70, 70, 70),
      ),
      child: TextField(
        controller: newTaskDescriptionController,
        decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.description_outlined,
              color: Colors.orange,
            ),
            border: InputBorder.none,
            label: Text(
              "Description",
              style: TextStyle(color: Colors.orange),
            ),
            hintStyle: TextStyle(color: Colors.orange),
            hintText: "(Optional)"),
      ),
    );
  }

  Container buildTaskNameContainer() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 70, 70, 70),
      ),
      child: TextField(
        controller: newTaskNameController,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.note_alt_outlined,
            color: Colors.orange,
          ),
          border: InputBorder.none,
          label: Text(
            "Task Name",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }
}
