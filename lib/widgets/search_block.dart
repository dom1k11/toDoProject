import 'package:flutter/material.dart';

class SearchBlockWidget extends StatelessWidget {
  const SearchBlockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
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
