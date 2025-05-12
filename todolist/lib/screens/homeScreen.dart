import 'package:flutter/material.dart';
import '../widgets/backtrackingSearch.dart';
import '../widgets/daftarTugas.dart';
import '../screens/settingScreen.dart';
import '../screens/loginScreen.dart';

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

  @override
  void initState() {
    super.initState();
    _filteredTodos = List.from(_todos);
    _searchController.addListener(_filterTodosWithBacktracking);
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
      appBar: AppBar(
        title: const Text('Todo List'),
        backgroundColor: Colors.yellowAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.yellowAccent),
              child: Text('Menu', style: TextStyle(fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Masuk'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.yellowAccent,
          image: DecorationImage(
            image: AssetImage('assets/images/avHome.jpg'),
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
                decoration: const InputDecoration(
                  labelText: 'Tambah Tugas',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.note_add),
                ),
              ),
              ElevatedButton(onPressed: _addTodo, child: const Text('+')),
              const SizedBox(height: 20),
              Expanded(
                child:
                    _filteredTodos.isEmpty
                        ? const Center(child: Text('Belum ada tugas'))
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
