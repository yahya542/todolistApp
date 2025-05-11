import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'component/backtrackingSearch.dart'; // Import widget pencarian
import 'component/daftarTugas.dart';    // Impor widget daftar tugas

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Text  'Todo List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        primarySwatch: Colors.blueGrey,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrange,
            fontFamily: 'Righteous',
          ),
          bodyMedium: TextStyle(fontSize: 18),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.teal),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
          ),
        ),
      ),
      home: const TodoHomePage(),
    );
  }
}//tes

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  _TodoHomePageState createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<String> _todos = [];
  final List<String> _filteredTodos = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
    _searchController.addListener(_filterTodosWithBacktracking);
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');
    if (todosString != null) {
      setState(() {
        _todos.addAll(List<String>.from(jsonDecode(todosString)));
        _filteredTodos.addAll(_todos);
      });
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todos', jsonEncode(_todos));
  }

  void _addTodo() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      setState(() {
        _todos.add(text);
        _controller.clear();
      });
      _saveTodos();
      _filterTodosWithBacktracking();
    }
  }

  void _removeTodo(int index) {
    final String todoToRemove = _filteredTodos[index];
    setState(() {
      _todos.remove(todoToRemove);
    });
    _saveTodos();
    _filterTodosWithBacktracking();
  }

  void _editTodo(int index, String oldText) {
    _controller.text = oldText; 
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Tugas'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Tugas'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                 final updatedText = _controller.text; 
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    _todos[_todos.indexOf(_filteredTodos[index])] = updatedText;
                      _filteredTodos[index] = updatedText;
                  });
                  _saveTodos();
                  _filterTodosWithBacktracking();
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog tanpa menyimpan
              },
              child: const Text('Batal'),
            ),
          ],
        );
      },
    );
  }

  bool isMatch(String word, String pattern, int wIndex, int pIndex) {
    if (pIndex == pattern.length) return true;
    if (wIndex == word.length) return false;

    if (word[wIndex].toLowerCase() == pattern[pIndex].toLowerCase()) {
      if (isMatch(word, pattern, wIndex + 1, pIndex + 1)) return true;
    }

    return isMatch(word, pattern, wIndex + 1, pIndex);
  }

  List<String> searchByLettersBacktracking(List<String> todos, String pattern) {
    List<String> results = [];
    for (String todo in todos) {
      if (isMatch(todo, pattern, 0, 0)) {
        results.add(todo);
      }
    }
    return results;
  }

  void _filterTodosWithBacktracking() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredTodos.clear();
      if (query.isEmpty) {
        _filteredTodos.addAll(_todos);
      } else {
        _filteredTodos.addAll(searchByLettersBacktracking(_todos, query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To do list')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gunakan widget TodoSearchWidget
            TodoSearchWidget(
              searchController: _searchController,
              onSearchChanged: (query) {
                _filterTodosWithBacktracking();
              },
            ),
            const SizedBox(height: 16),
            // Gunakan widget TodoListWidget
            TodoListWidget(
              todos: _filteredTodos,
              onDelete: (index) => _removeTodo(index),
              onEdit: (index, oldText) => _editTodo(index, oldText), // Panggil editTodo
            ),
            const SizedBox(height: 16),
            // Input tambah tugas
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Tambahkan Tugas',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTodo,
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
