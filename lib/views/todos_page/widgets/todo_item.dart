import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_jar/models/todo_model.dart';
import 'package:tech_jar/providers/todos_provider.dart';

class TodoItem extends ConsumerStatefulWidget {
  final TodoModel todoModel;
  const TodoItem({
    super.key,
    required this.todoModel,
  });

  @override
  ConsumerState<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  bool isCompleted = false;

  @override
  void initState() {
    isCompleted = widget.todoModel.completed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.todoModel.todo,
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
              ref.watch(todosProvider).toggle(widget.todoModel.id);
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
              TextButton(
                onPressed: () {
                  ref.watch(todosProvider).removeTodo(
                        widget.todoModel.id,
                      );
                  Navigator.of(context).pop();
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
            ],
          );
        });
  }

  void showEditAction() {
    final TextEditingController _textEditingController =
        TextEditingController(text: widget.todoModel.todo);
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Edit task'),
            content: TextField(
              autofocus: true,
              controller: _textEditingController,
              decoration: const InputDecoration(
                labelText: 'Task Name',
                hintText: 'New task',
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    ref.watch(todosProvider).update(
                        _textEditingController.text, widget.todoModel.id);

                    Navigator.of(context).pop();
                  },
                  child: Text('OK')),
            ],
          );
        });
  }
}
