// lib/screens/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learning/controllers/crud_controller.dart';
import '../controllers/todo_controller.dart'; // <--- path check karo

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  final TextEditingController todoController = TextEditingController();

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final todos = ref.watch(todoControllerProvider);
    final cruds = ref.watch(crudControllerProvider);
    cruds.reversed;

    return Scaffold(
      appBar: AppBar(title: const Text('Todo Screen')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                      hintText: 'Todo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {
                    final text = todoController.text;
                    if (text.trim().isEmpty) return;
                    // <-- call controller method via provider notifier
                    // ref.read(todoControllerProvider.notifier).addTodo(text);
                    ref
                        .read(crudControllerProvider.notifier)
                        .postCrud(todoController.text);
                    // todoController.clear();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: cruds.length,
                itemBuilder: (context, index) {
                  final crud = cruds[index];
                  return Card(
                    child: ListTile(
                      title: Text(crud['name']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          ref
                              .read(todoControllerProvider.notifier)
                              .removeTodo(crud);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Text("Get Data"),
      //   onPressed: () {
      //     ref.read(crudControllerProvider.notifier).getCrud();
      //   },
      // ),
    );
  }
}
