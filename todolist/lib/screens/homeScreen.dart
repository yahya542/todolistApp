import 'package:flutter/material.dart';
import '../widgets/backtrackingSearch.dart';
import '../widgets/daftarTugas.dart';
import '../widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _todos = [];
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredTodos = [];

  bool isDark = true; 

  @override
  void initState() {
    super.initState();
    _filteredTodos = List.from(_todos);
    _searchController.addListener(_filterTodosWithBacktracking);
  }

  void _toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }

  void _addTodo() {
    final text = _controller.text;
    if (text.isNotEmpty) {
      setState(() {
        _todos.add(text);
        _filteredTodos.add(text);
        _controller.clear();
      });
    }
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
      _filteredTodos.removeAt(index);
    });
  }

  void _editTodo(int index, String currentText) {
    final editController = TextEditingController(text: currentText);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Tugas'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(hintText: 'Tugas baru'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final newText = editController.text.trim();
                if (newText.isNotEmpty) {
                  final originalIndex = _todos.indexOf(_filteredTodos[index]);
                  setState(() {
                    _todos[originalIndex] = newText;
                    _filteredTodos[index] = newText;
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _filterTodosWithBacktracking() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _filteredTodos =
          _todos.where((todo) => todo.toLowerCase().contains(query)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                isDark
                    ? 'assets/images/avHome.jpg'
                    : 'assets/images/carsdark.jpg',
              ),
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            title: const Text(
              'Todo List',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isDark ? Icons.wb_sunny : Icons.nightlight_round,
                  color: Colors.white,
                ),
                onPressed: _toggleTheme,
              ),
            ],
          ),
        ),
      ),
      drawer: const DrawerWidget(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? 'assets/images/avHome.jpg'
                  : 'assets/images/carsdark.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TodoSearchWidget(
                searchController: _searchController,
                onSearchChanged: (query) {
                  _filterTodosWithBacktracking();
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Tambah list',
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note_add, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: _addTodo, child: const Text('+')),
              const SizedBox(height: 20),
              Expanded(
                child: _filteredTodos.isEmpty
                    ? const Center(
                        child: Text(
                          'Belum ada tugas',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : TodoListWidget(
                        todos: _filteredTodos,
                        onDelete: _removeTodo,
                        onEdit: _editTodo,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
