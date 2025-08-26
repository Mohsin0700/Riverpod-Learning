// lib/controllers/todo_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoController extends StateNotifier<List<String>> {
  TodoController() : super([]);

  void addTodo(String todo) {
    if (todo.trim().isEmpty) return;
    state = [...state, todo.trim()];
  }

  void removeTodo(String todo) {
    state = state.where((item) => item != todo).toList();
  }
}

// -- Provider (TOP-LEVEL) --
final todoControllerProvider =
    StateNotifierProvider<TodoController, List<String>>((ref) {
      return TodoController();
    });
