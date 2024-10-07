import 'package:flutter/material.dart';

class Priority {
  final String name;
  final Color color;
  final IconData icon; // Добавляем поле для иконки

  Priority(this.name, this.color, this.icon); // Обновляем конструктор
}

final List<Priority> dropdownList = [
  Priority('High', Colors.red, Icons.warning), // Иконка для высокого приоритета
  Priority('Medium', Colors.yellow, Icons.info), // Иконка для среднего приоритета
  Priority('Low', Colors.green, Icons.flag_circle), // Иконка для низкого приоритета
];


class DropdownMenuBlock extends StatefulWidget {
  const DropdownMenuBlock({super.key});

  @override
  State<DropdownMenuBlock> createState() => _DropdownMenuBlockState();
}

class _DropdownMenuBlockState extends State<DropdownMenuBlock> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 70, 70, 70),
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        icon: const Icon(Icons.priority_high_outlined, color: Colors.orange),
        dropdownColor: const Color.fromARGB(255, 70, 70, 70),
        style: const TextStyle(color: Colors.orange),
        isExpanded: true,
        hint: const Text("Select Priority"),
        value: dropdownValue,
        onChanged: (value) {
          setState(() {
            dropdownValue = value; // value теперь является String?
          });
        },
        items: dropdownList.map((priority) {
          return DropdownMenuItem<String>(
            value: priority.name, // Передаем имя приоритета
            child: Row(
              children: [
                Icon(priority.icon, color: priority.color), // Иконка приоритета
                SizedBox(width: 10), // Отступ между иконкой и текстом
                Text(
                  priority.name, // Название приоритета
                  style: TextStyle(color: priority.color), // Применяем цвет
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
