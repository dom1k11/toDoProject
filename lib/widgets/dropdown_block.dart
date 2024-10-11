import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:to_do_app_practice_2/utils/task_helpers.dart'; // Импортируйте ваш файл

class DropdownMenuBlock extends StatefulWidget {
  const DropdownMenuBlock({super.key, required this.onPrioritySelected});

  final Function(String) onPrioritySelected;

  @override
  State<DropdownMenuBlock> createState() => _DropdownMenuBlockState();
}

class _DropdownMenuBlockState extends State<DropdownMenuBlock> {
  String dropdownValue = 'Default'; // Устанавливаем значение по умолчанию
  bool isDropdownOpened = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: isDropdownOpened
            ? const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        )
            : BorderRadius.circular(8),
        color: const Color.fromARGB(255, 70, 70, 70),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          dropdownStyleData: DropdownStyleData(
            elevation: 0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: const Color.fromARGB(255, 70, 70, 70),
            ),
          ),
          isExpanded: true,
          hint: const Row(
            children: [
              Icon(Icons.priority_high_outlined, color: Colors.orange),
              SizedBox(width: 10),
              Text("Select Priority", style: TextStyle(color: Colors.white)),
            ],
          ),
          value: dropdownValue, // Установите текущее значение
          items: dropdownList.map((priority) {
            return DropdownMenuItem<String>(
              value: priority.name,
              child: Row(
                children: [
                  Icon(priority.icon, color: priority.color),
                  const SizedBox(width: 10),
                  Text(priority.name, style: TextStyle(color: priority.color)),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              dropdownValue = value ?? 'Default'; // Если значение null, устанавливаем 'Default'
            });
            if (value != null) {
              widget.onPrioritySelected(value);
            }
          },
          onMenuStateChange: (isOpen) {
            setState(() {
              isDropdownOpened = isOpen;
            });
          },
        ),
      ),
    );
  }
}
