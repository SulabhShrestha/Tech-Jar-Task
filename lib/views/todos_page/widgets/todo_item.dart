import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Task name',
        style: TextStyle(
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // completing
          Checkbox(
            value: isCompleted,
            onChanged: (value) {
              setState(() {
                isCompleted = value!;
              });
            },
          ),

          // editing
          IconButton(
            onPressed: () {
              showEditAction();
            },
            icon: Icon(Icons.edit),
          ),

          // deleting
          IconButton(
            onPressed: () {
              showDeleteAction();
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }

  void showDeleteAction() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Delete task?'),
            actions: [
              TextButton(onPressed: () {}, child: Text('Yes')),
              TextButton(onPressed: () {}, child: Text('No')),
            ],
          );
        });
  }

  void showEditAction() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Edit task'),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Task Name',
                hintText: 'eg. Buy milk',
              ),
            ),
            actions: [
              TextButton(onPressed: () {}, child: Text('OK')),
            ],
          );
        });
  }
}
