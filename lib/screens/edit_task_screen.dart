import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/buttons/custom_floating_action_button.dart';
import 'package:to_do_app_practice_2/screens/new_task_screen.dart';
import 'package:to_do_app_practice_2/widgets/dropdown_block.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  @override
  Widget build(BuildContext context) {
    bool showFab = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Task'),
        backgroundColor: Colors.blueAccent,
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
      floatingActionButton: Visibility(
        visible: !showFab,
        child: CustomFloatingActionButton(
          onPressed: () {// Передаем контекст и функцию сброса
          },
          color: Colors.blueAccent, // Задайте нужный цвет
          icon: Icons.edit, labelText: "Edit Task", // Задайте нужную иконку
        ),
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
        enableInteractiveSelection: false,
        controller: newTaskDateTimeController,
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime.now(),
              maxTime: DateTime(2026, 12, 31), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                setState(() {
                  newTaskDateTimeController.text =
                      DateFormat('MMM d, yyyy').format(date);
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
        maxLines: 5,
        controller: newTaskDescriptionController,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.description_outlined,
            color: Colors.orange,
          ),
          border: InputBorder.none,
          label: const Text(
            "Description",
            style: TextStyle(color: Colors.orange),
          ),
          alignLabelWithHint: true,
          // Выравнивает метку и иконку по верхнему краю
          hintStyle: TextStyle(color: Colors.grey.shade500),
          hintText: "(Optional)",
        ),
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

Container buildTaskDescriptionContainer() {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 70, 70, 70),
      ),
      child: const TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.description_outlined,
              color: Colors.orange,
            ),
            border: InputBorder.none,
            label: Text(
              "Edit Description",
              style: TextStyle(color: Colors.orange),
            ),
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
      child: const TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.note_alt_outlined,
            color: Colors.orange,
          ),
          border: InputBorder.none,
          label: Text(
            "Edit Task Name",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }


Container buildDropdownContainer() {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color.fromARGB(255, 70, 70, 70),
    ),
    child: TextField(
      readOnly: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.priority_high_outlined,
          color: Colors.orange,
        ),
        border: InputBorder.none,
      ),
      onTap: () {},
    ),
  );
}
