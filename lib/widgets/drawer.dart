import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          ListTile(
            leading: const Icon(Icons.done),
            title: const Text('Done Tasks'),
            onTap:  () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/done_task_screen');
            },
          ),
        ],
      ),
    );
  }
}
