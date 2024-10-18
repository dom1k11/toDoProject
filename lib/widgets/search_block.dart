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
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.content_paste_search,
          color: Colors.orange,
        ),
        suffixIcon: Icon(
          Icons.search,
          color: Colors.orange,
        ),
        border: InputBorder.none,
        hintText: "Search",
      ),
    );
  }
}
