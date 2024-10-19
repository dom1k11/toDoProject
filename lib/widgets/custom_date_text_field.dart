import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_practice_2/screens/edit_task_screen.dart';

class CustomDateTextField extends StatelessWidget {
  final TextEditingController controller;
  final BuildContext context;
  final String hintText;

  const CustomDateTextField({
    required this.controller,
    required this.context,
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        DatePicker.showDatePicker(this.context,
            showTitleActions: true,
            minTime: DateTime.now(),
            maxTime: DateTime(2026, 12, 31),
            onChanged: (date) {
              print('change $date');
            },
            onConfirm: (date) {
              controller.text = DateFormat('MMM d, yyyy').format(date);
              print('confirm $date');

            },
            currentTime: DateTime.now(),
            locale: LocaleType.en);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 70, 70, 70),
        ),
        child: AbsorbPointer( // Это предотвращает взаимодействие с текстовым полем, чтобы только нажатие на контейнер открывало выбор даты
          child: TextField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              label: Text(
                hintText,
                style: const TextStyle(color: Colors.orange),
              ),
              prefixIcon: const Icon(
                Icons.date_range_outlined,
                color: Colors.orange,
              ),
              border: InputBorder.none,
              hintText: "Date",
            ),
          ),
        ),
      ),
    );
  }
}
