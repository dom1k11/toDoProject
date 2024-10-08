import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
class DatetimePicker extends StatelessWidget {
  const DatetimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2018, 3, 5),
              maxTime: DateTime(2019, 6, 7), onChanged: (date) {
                print('change $date');
              }, onConfirm: (date) {
                print('confirm $date');
              }, currentTime: DateTime.now(), locale: LocaleType.en);
        },
        child: Text(
          'show date time picker (Chinese)',
          style: TextStyle(color: Colors.blue),
        ));
  }
}
