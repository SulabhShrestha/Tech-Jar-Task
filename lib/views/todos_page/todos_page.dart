import 'package:flutter/material.dart';
import 'package:tech_jar/views/todos_page/widgets/todo_item.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodo(context);
        },
        child: Icon(Icons.add),
      ),
      body: Column(children: [
        Text("Today's tasks"),
        Expanded(
          child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return const TodoItem();
            },
          ),
        ),
      ]),
    );
  }

  void addTodo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("New task"),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Task Name',
              hintText: 'eg. Buy milk',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
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
