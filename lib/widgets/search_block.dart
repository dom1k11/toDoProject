import 'package:flutter/material.dart';

class SearchBlockWidget extends StatefulWidget {
  SearchBlockWidget({super.key});

  @override
  State<SearchBlockWidget> createState() => _SearchBlockWidgetState();
}

class _SearchBlockWidgetState extends State<SearchBlockWidget> {
  TextEditingController textFilterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFilterController,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          Icons.content_paste_search,
          color: Colors.orange,
        ),
        suffixIcon: IconButton(
          color: Colors.orange,
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          icon: const Icon(
            Icons.search,
          ),
        ),
        border: InputBorder.none,
        hintText: "Search",
      ),
    );
  }
}
