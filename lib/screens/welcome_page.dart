import 'package:flutter/material.dart';
import 'package:to_do_app_practice_2/buttons/custom_floating_action_button.dart';
import 'package:to_do_app_practice_2/buttons/get_started_button.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        backgroundColor: Colors.white70,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 100),
          margin: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(
                  'images/to_do_img.png',
                  width: 200,
                  height: 200,
                ),
              ),
              Container(
                child: Text(
                  "Your convenient task manager",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              Text(
                "Welcome to intuitive and convenient"
                "interface for your to-do tasks management",
                style: TextStyle(color: Colors.white38),
              ),
              GetStartedButton(),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/tasks_page');
                  },
                  child: Text("Continue without registration", style: TextStyle(color: Colors.white24),))
            ],
          ),
        ),
      ),
    );
  }
}
