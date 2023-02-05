import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addTodo();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('${_todos[index].name}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _todos.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }

  void _addTodo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
      String? taskName;
      return AlertDialog(
        title: const Text('Add Todo'),
        content: TextField(
          onChanged: (String value) {
            taskName = value;
          },
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Add'),
            onPressed: () {
              setState(() {
                _todos.add(Todo(name: taskName));
              });
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
        },
    );
  }
}
