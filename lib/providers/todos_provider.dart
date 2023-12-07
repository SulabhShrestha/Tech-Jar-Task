import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/models/todo_model.dart';

class TodosNotifier extends ChangeNotifier {
  final todos = <TodoModel>[];

  void addTodo(TodoModel todo) {
    todos.add(todo);
    notifyListeners();
  }

  void removeTodo(String todoId) {
    todos.remove(todos.firstWhere((element) => element.id == todoId));
    notifyListeners();
  }

  void toggle(String todoId) {
    final todo = todos.firstWhere((todo) => todo.id == todoId);
    todo.completed = !todo.completed;
    notifyListeners();
  }

  void update(String newTodo, String todoId) {
    final todo = todos.firstWhere((todo) => todo.id == todoId);
    todo.todo = newTodo;
    notifyListeners();
  }
}

final todosProvider = ChangeNotifierProvider<TodosNotifier>((ref) {
  return TodosNotifier();
});
