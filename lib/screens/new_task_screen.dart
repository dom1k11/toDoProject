import 'package:flutter/material.dart';
import 'package:to_do_app_practice_2/buttons/custom_floating_action_button.dart';
import 'package:to_do_app_practice_2/widgets/dropdown_block.dart';
import 'package:to_do_app_practice_2/services/task_service.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
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
          //   buildDropdownContainer(),
          const DropdownMenuBlock(),
        ],
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: addTask,
        color: Colors.red, // Задайте нужный цвет
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
      child: const TextField(
        readOnly: true,
        decoration: InputDecoration(
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
      child: const TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.description_outlined,
              color: Colors.orange,
            ),
            border: InputBorder.none,
            label: Text(
              "Description",
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
            "Task Name",
            style: TextStyle(color: Colors.orange),
          ),
        ),
      ),
    );
  }
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
        hintText: "Priority",
      ),
      onTap: () {},
    ),
  );
}
