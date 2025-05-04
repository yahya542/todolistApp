// todo_list.dart
import 'package:flutter/material.dart';

class TodoListWidget extends StatelessWidget {
  final List<String> todos;
  final Function(int) onDelete;
  final Function(int, String) onEdit;

  const TodoListWidget({
    super.key,
    required this.todos,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(todos[index]),
              trailing:  Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => onEdit(index, todos[index]), // Menangani edit
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => onDelete(index), // Menangani delete
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
