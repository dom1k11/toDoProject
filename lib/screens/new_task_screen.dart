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
    newTaskDateTimeController.text = DateFormat('MMM d, yyyy').format(DateTime.now().add(Duration(days: 7)));

  }

  void resetPriority() {
    setState(() {
      selectedPriority = 'Default'; // Сброс значения приоритета на значение по умолчанию
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
          onPressed: () {
            addTask(context, resetPriority); // Передаем контекст и функцию сброса
          },
          color: Colors.greenAccent, // Задайте нужный цвет
          icon: Icons.add, // Задайте нужную иконку
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
              newTaskDateTimeController.text = DateFormat('MMM d, yyyy').format(date);

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
            hintStyle: TextStyle(color: Colors.grey.shade500),
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
