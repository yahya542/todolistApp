// todo_search.dart
import 'package:flutter/material.dart';

class TodoSearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const TodoSearchWidget({
    super.key,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Cari Tugas...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: onSearchChanged, // Menangani perubahan teks pencarian
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
