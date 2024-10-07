import 'package:flutter/material.dart';
import 'package:to_do_app_practice_2/widgets/dropdown_block.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  @override
  Widget build(BuildContext context) {
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
          //   buildDropdownContainer(),
          const DropdownMenuBlock(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
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
          hintText: "Edit Date",
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
