import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ElevatedButton(

          onPressed: () {
            Navigator.pushNamed(context, '/tasks_page');
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              foregroundColor: Colors.black, // foreground (text) color
              backgroundColor: Colors.white,
              elevation: 8,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20)),
          child: Text("Get Started"),
        ),
      ),
    );
  }
}
