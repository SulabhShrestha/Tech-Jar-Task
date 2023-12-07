import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/models/todo_model.dart';
import 'package:tech_jar/providers/todos_provider.dart';
import 'package:tech_jar/views/todos_page/widgets/todo_item.dart';

class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider).todos;

    return Scaffold(
      appBar: AppBar(
        title: Text('Todos Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo(context, ref);
        },
        child: Icon(Icons.add),
      ),
      body: Column(children: [
        Text("Today's tasks"),
        Expanded(
          child: ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return TodoItem(
                todoModel: todos[index],
              );
            },
          ),
        ),
      ]),
    );
  }

  void addTodo(BuildContext context, WidgetRef ref) {
    final TextEditingController _textEditingController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("New task"),
          content: TextField(
            controller: _textEditingController,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Task Name',
              hintText: 'eg. Buy milk',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ref.watch(todosProvider).addTodo(
                      TodoModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        todo: _textEditingController.text,
                        completed: false,
                      ),
                    );
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
